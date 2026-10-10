#!/data/data/com.termux/files/usr/bin/bash
set -eu
cd "$(dirname "$0")"
unset LD_PRELOAD

printf '\n\033[93mAnand Linux — Termux/PRoot installer\033[0m\n\n'

for pkg in proot wget tar xz-utils; do
  if ! command -v "$pkg" >/dev/null 2>&1; then
    echo "Installing required package: $pkg"
    pkg install -y "$pkg"
  fi
done

ROOT="anand-fs"
BIND_DIR="anand-binds"
ARCHIVE="anand-rootfs.tar.xz"

if [ -d "$ROOT" ] && {
  [ -x "$ROOT/bin/bash" ] || [ -x "$ROOT/usr/bin/bash" ];
}; then
  echo "Anand root filesystem already exists; skipping download."
else
  if [ -e "$ROOT" ]; then
    echo "ERROR: $ROOT exists but is incomplete."
    echo "Back it up and inspect it first."
    exit 1
  fi

  case "$(dpkg --print-architecture)" in
    aarch64) arch="arm64" ;;
    arm) arch="armhf" ;;
    amd64|x86_64) arch="amd64" ;;
    i386|i486|i586|i686|x86) arch="i386" ;;
    *)
      echo "Unsupported architecture: $(dpkg --print-architecture)"
      exit 1
      ;;
  esac

  url="https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Kali/${arch}/kali-rootfs-${arch}.tar.xz"

  if [ ! -f "$ARCHIVE" ]; then
    echo "Downloading upstream rootfs for $arch..."
    wget -O "$ARCHIVE.part" "$url" || {
      rm -f "$ARCHIVE.part"
      echo "Download failed; check the upstream URL."
      exit 1
    }
    mv "$ARCHIVE.part" "$ARCHIVE"
  fi

  mkdir -p "$ROOT"
  echo "Extracting root filesystem..."

  if ! proot --link2symlink tar -xJf "$ARCHIVE" -C "$ROOT"; then
    echo "Extraction failed; archive retained for troubleshooting."
    exit 1
  fi

  if [ ! -x "$ROOT/bin/bash" ] && [ ! -x "$ROOT/usr/bin/bash" ]; then
    echo "ERROR: no usable Bash found in extracted rootfs."
    exit 1
  fi

  rm -f "$ARCHIVE"
fi

# Configure Anand Linux red prompt
mkdir -p "$ROOT/root"

cat > "$ROOT/root/.bashrc" <<'PROMPT'
# Anand Linux - Kali-style red terminal
PS1='\[\033[1;31m\]┌──(Anand㉿Linux)-[\w]\n└─# \[\033[0m\]'
PROMPT

cat > "$ROOT/root/.bash_profile" <<'PROFILE'
# Load interactive Bash configuration on login
if [ -f /root/.bashrc ]; then
  . /root/.bashrc
fi
PROFILE

mkdir -p "$BIND_DIR"

cat > start-anand.sh <<'LAUNCHER'
#!/data/data/com.termux/files/usr/bin/bash
set -eu
cd "$(dirname "$0")"
unset LD_PRELOAD

ROOT="anand-fs"
BIND_DIR="anand-binds"

[ -d "$ROOT" ] || {
  echo "Root filesystem missing: $ROOT. Run ./Anand.sh first."
  exit 1
}

cmd=(proot --link2symlink -0 -r "$ROOT")

if [ -d "$BIND_DIR" ]; then
  for f in "$BIND_DIR"/*; do
    [ -f "$f" ] || continue
    . "$f"
  done
fi

cmd+=(-b /dev -b /proc -b "$ROOT/tmp:/dev/shm")
[ ! -d /sdcard ] || cmd+=(-b /sdcard)

cmd+=(
  -w /root
  /usr/bin/env -i
  HOME=/root
  PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games
  TERM="${TERM:-xterm-256color}"
  LANG=C.UTF-8
  /bin/bash --login
)

if [ "$#" -eq 0 ]; then
  exec "${cmd[@]}"
else
  exec "${cmd[@]}" -c "$*"
fi
LAUNCHER

chmod +x Anand.sh start-anand.sh

if command -v termux-fix-shebang >/dev/null 2>&1; then
  termux-fix-shebang Anand.sh start-anand.sh
fi

printf '\nAnand Linux setup is ready.\n'
printf 'Launch with: ./start-anand.sh\n'
printf 'Prompt: Anand㉿Linux (red)\n'
printf 'Note: upstream rootfs/package identity may remain Kali-derived.\n'
