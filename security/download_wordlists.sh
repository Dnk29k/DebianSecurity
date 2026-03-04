#!/bin/bash
# --- Phoenix Security: Wordlist Manager ---

WLIST_DIR="/usr/share/wordlists"
ROCKYOU_URL="https://github.com/brannondorsey/naive-hash-cat/releases/download/data/rockyou.txt"

echo -e "\e[1;34m[*] Verificando diccionario RockYou...\e[0m"

if [ ! -d "$WLIST_DIR" ]; then
    sudo mkdir -p "$WLIST_DIR"
fi

if [ -f "$WLIST_DIR/rockyou.txt" ]; then
    echo -e "\e[1;32m[+] RockYou ya existe en $WLIST_DIR\e[0m"
else
    echo -e "\e[1;33m[*] Descargando RockYou.txt...\e[0m"
    sudo wget "$ROCKYOU_URL" -O "$WLIST_DIR/rockyou.txt"
    echo -e "\e[1;32m[+] Descarga completada.\e[0m"
fi

ln -sf "$WLIST_DIR" "$HOME/tools/wordlists"
EOF
