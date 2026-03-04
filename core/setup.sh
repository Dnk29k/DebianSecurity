#!/bin/bash
# --- Phoenix Architecture: Setup Maestro ---

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="$HOME/tools"

echo -e "\e[1;34m[*] Iniciando despliegue de DebianSecurity...\e[0m"

# 1. Repositorios y Paquetes Esenciales
sudo apt update
sudo apt install -y git python3-pip python3-venv pipx bat lsd xclip feh bspwm sxhkd polybar picom kitty

# 2. Escudo contra errores de Python (NetExec & Impacket)
echo -e "\e[1;32m[*] Instalando Arsenal de Red (nxc, updog)...\e[0m"
pipx install git+https://github.com/Pennyw0rth/NetExec --force
pipx install updog

# 3. Lógica de BurpSuite (Symlink automático)
if [ -f "/opt/BurpSuiteCommunity/burpsuite" ]; then
    sudo ln -sf /opt/BurpSuiteCommunity/burpsuite /usr/local/bin/burpsuite
    echo -e "\e[1;32m[+] Symlink de BurpSuite creado en /usr/local/bin\e[0m"
fi

# 4. Wordlists (Rockyou setup)
sudo mkdir -p /usr/share/wordlists
if [ ! -f "/usr/share/wordlists/rockyou.txt" ]; then
    echo -e "\e[1;33m[*] Descargando Rockyou...\e[0m"
    sudo wget https://github.com/brannondorsey/naive-hash-cat/releases/download/data/rockyou.txt -O /usr/share/wordlists/rockyou.txt
fi

echo -e "\e[1;34m[+] Entorno Phoenix desplegado al 100%.\e[0m"
