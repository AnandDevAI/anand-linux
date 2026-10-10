Anand Linux for Termux

Anand Linux is an Anand-branded Linux environment for Android using Termux and PRoot.

Installation

1. Update Termux

pkg update && pkg upgrade -y

2. Install Git

pkg install -y git

3. Clone repository

git clone https://github.com/AnandDevAI/anand-linux.git

4. Open folder

cd ~/anand-linux

5. Run installer

chmod +x Anand.sh
./Anand.sh

Start Anand Linux

./start-anand.sh

Red Terminal Prompt

┌──(Anand㉿Linux)-[~]
└─#

Features

- Red Kali-style prompt
- Termux + PRoot
- No rooted phone required

Disclaimer

PRoot is not real root access. The upstream root filesystem may remain Kali-derived.

Author

AnandDevAI

"GitHub Repository" (https://github.com/AnandDevAI/anand-linux)
