# Anand Linux for Termux

Anand Linux is an Anand-branded Linux environment for Android/Termux using PRoot.

## Requirements
- Termux
- Supported CPU architecture (ARM64/AArch64 recommended)
- Internet access and enough free storage

## Install
```bash
chmod +x Anand.sh
./Anand.sh
```

Start the environment:
```bash
./start-anand.sh
```

## Upstream compatibility
The installer retains the upstream EXALAB AnLinux-Resources URL, including its `Kali` path, because changing upstream URLs can break downloads. This project changes local branding and filenames; it does not claim that the upstream root filesystem or package repositories were independently created by Anand Linux. It does not use the NetHunter installer.

If download fails, verify the current rootfs path in https://github.com/EXALAB/AnLinux-Resources. PRoot is not real kernel root access; Android restrictions still apply.

## Files
- `Anand.sh` — installer
- `start-anand.sh` — generated launcher
- `anand-binds/` — optional bind configuration snippets
- `anand-fs/` — installed root filesystem (not included in this ZIP)
