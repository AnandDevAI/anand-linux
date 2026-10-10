cd ~/anand-linux

cat > anand-theme.sh <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
set -eu

mkdir -p "$HOME/.termux"

THEME="$HOME/.termux/colors.properties"

if [ -f "$THEME" ]; then
    cp "$THEME" "$THEME.backup"
fi

cat > "$THEME" <<'COLORS'
background=#000000
foreground=#00ff00
cursor=#00ff00
color0=#000000
color1=#ff3333
color2=#00ff00
color3=#ffff00
color4=#4488ff
color5=#ff55ff
color6=#00ffff
color7=#cccccc
color8=#555555
color9=#ff5555
color10=#55ff55
color11=#ffff55
color12=#5599ff
color13=#ff55ff
color14=#55ffff
color15=#ffffff
COLORS

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

if ! grep -q 'ANAND_TERMUX_THEME' "$BASHRC"; then
    cat >> "$BASHRC" <<'PROMPT'

# ANAND_TERMUX_THEME
PS1='\[\033[1;31m\]┌──(Anand㉿Termux)-[\w]\n\[\033[1;32m\]└─\$\[\033[0m\] '
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PROMPT
fi

echo "Anand theme installed."
echo "Reload Termux settings to apply colors."
EOF

chmod +x anand-theme.sh
./anand-theme.sh
