Anand Linux for Termux

Anand Linux is an Anand-branded Linux environment for Android using Termux and PRoot, with a custom red "Anand㉿Linux" terminal prompt.

Features

- Kali-style red prompt
- Android/Termux support
- PRoot environment; no rooted phone required

Installation

1. Install Git

pkg update && pkg install -y git

2. Download the project

git clone https://github.com/AnandDevAI/anand-linux.git

3. Install Anand Linux

cd ~/anand-linux
chmod +x Anand.sh
./Anand.sh

Start

cd ~/anand-linux
./start-anand.sh

Expected prompt:

┌──(Anand㉿Linux)-[~]
└─#

Project Files

- "Anand.sh" — Installer
- "start-anand.sh" — Generated launcher
- "anand-binds/" — Optional bind configurations
- "anand-fs/" — Local root filesystem

Notes

- PRoot does not provide real root access.
- The root filesystem is obtained from "EXALAB/AnLinux-Resources" (https://github.com/EXALAB/AnLinux-Resources).
- Upstream distribution and package identity may remain Kali-derived.

Author

AnandDevAI

"GitHub Repository" (https://github.com/AnandDevAI/anand-linux)
