Anand Linux for Termux

Anand Linux is a lightweight, Anand-branded Linux environment for Android that runs through Termux and PRoot.

It provides a Linux command-line environment with custom Anand Linux branding and a Kali-style red terminal prompt.

Features

- Custom "Anand㉿Linux" terminal prompt.
- Kali-style red prompt with the current working directory.
- Automatic installation of required Termux packages.
- PRoot-based Linux environment without requiring a rooted Android device.
- Automatically generated "start-anand.sh" launcher.
- Optional bind configuration through "anand-binds/".
- Support for multiple CPU architectures, depending on upstream root filesystem availability.

Requirements

- Android device with Termux installed.
- ARM64/AArch64 recommended.
- Internet connection for downloading the root filesystem.
- Sufficient free storage for the downloaded archive and extracted Linux environment.

Installation

Open Termux and run:

pkg update
pkg install -y git
git clone https://github.com/AnandDevAI/anand-linux.git
cd anand-linux
chmod +x Anand.sh
./Anand.sh

The installer checks for required packages, downloads the configured upstream root filesystem if necessary, extracts it, configures the Anand Linux prompt, and generates the launcher.

Note: The initial installation may take some time depending on your internet speed and available storage.

Start Anand Linux

After installation, run:

cd ~/anand-linux
./start-anand.sh

The terminal prompt should look like this:

┌──(Anand㉿Linux)-[~]
└─#

The prompt uses red ANSI text. The terminal background and overall color scheme depend on your Termux theme.

Update the Terminal Prompt

If Anand Linux is already installed, you can configure the prompt without downloading the root filesystem again:

cd ~/anand-linux
mkdir -p anand-fs/root

Create the Bash configuration:

cat > anand-fs/root/.bashrc <<'EOF'
PS1='\[\033[1;31m\]┌──(Anand㉿Linux)-[\w]\n└─# \[\033[0m\]'
EOF

Configure the login shell to load ".bashrc":

cat > anand-fs/root/.bash_profile <<'EOF'
if [ -f /root/.bashrc ]; then
    . /root/.bashrc
fi
EOF

Restart Anand Linux:

./start-anand.sh

Project Files

File or directory| Purpose
"Anand.sh"| Installer and prompt configuration
"start-anand.sh"| Generated Linux launcher
"README.md"| Project documentation
"LICENSE"| Project license
"anand-binds/"| Optional bind configuration snippets
"anand-fs/"| Installed root filesystem; not included in the repository

Upstream Compatibility

The installer uses the configured root filesystem URL from "EXALAB/AnLinux-Resources" (https://github.com/EXALAB/AnLinux-Resources), including its Kali directory.

Anand Linux adds local branding and configuration. It does not claim that the upstream root filesystem, distribution, or package repositories were independently created by this project.

This project does not use the Kali NetHunter installer.

The upstream download URL and supported architectures may change. If installation fails, check the upstream repository and verify that the requested root filesystem archive exists.

Security and Limitations

- PRoot does not provide real kernel-level root access.
- The environment remains subject to Android's security restrictions.
- A custom terminal prompt changes the displayed name, not the underlying Linux distribution.
- Package availability depends on the configured root filesystem and its repositories.
- Do not execute untrusted bind configuration snippets; the launcher sources files from "anand-binds/" as shell code.

Troubleshooting

Launcher not found

chmod +x Anand.sh
./Anand.sh

Root filesystem missing

Run the installer again:

./Anand.sh

Prompt does not appear red

Check the Bash configuration:

cat anand-fs/root/.bashrc
cat anand-fs/root/.bash_profile

Then exit the environment and start it again:

./start-anand.sh

Download fails

Check your internet connection and verify the upstream root filesystem URL.

License

See the ""LICENSE"" (LICENSE) file for the terms applicable to this project.

---

Anand Linux
Anand-branded Linux environment for Android and Termux.
