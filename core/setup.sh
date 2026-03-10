#!/bin/bash
# --- Phoenix Architecture: Setup Maestro ---

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="$HOME/tools"

echo -e "\e[1;34m[*] Iniciando despliegue de DebianSecurity...\e[0m"

# 1. Repositorios y Paquetes Esenciales
sudo apt update
sudo apt install -y git python3-pip python3-venv pipx bat lsd xclip feh bspwm sxhkd polybar picom kitty

# --- 1.1 Soporte Nativo para Kitty (Evita letras duplicadas en SSH) ---
echo -e "\e[1;34m[*] Configurando base de datos de terminal para Kitty...\e[0m"
mkdir -p "$HOME/.terminfo/x"
# Si estamos en el MacBook, el archivo ya existe. Si estamos en una MV limpia, lo intentamos copiar.
if [ -f "/usr/share/terminfo/x/xterm-kitty" ]; then
    cp /usr/share/terminfo/x/xterm-kitty "$HOME/.terminfo/x/"
    echo -e "\e[1;32m[+] Terminfo de Kitty configurado localmente.\e[0m"
fi

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

# --- 5. Instalación de Arsenal Avanzado (VENV/PIPX) ---
echo -e "\e[1;34m[*] Instalando Arsenal de Hacking Avanzado...\e[0m"

# Herramientas de Red y Active Directory
pipx install impacket --force
pipx install certipy-ad
pipx install bloodhound

# Herramientas de Transferencia y Reconocimiento
pipx install updog
pipx install git+https://github.com/Pennyw0rth/NetExec --force

# --- 6. Despliegue de Fuentes (Fix Visual Polybar) ---
echo -e "\e[1;34m[*] Instalando fuentes del sistema...\e[0m"
mkdir -p "$HOME/.local/share/fonts"
cp -r "$REPO_ROOT/configs/polybar/fonts/"* "$HOME/.local/share/fonts/" 2>/dev/null
fc-cache -f -v

# --- 7. Wallpaper Setup ---
echo -e "\e[1;34m[*] Configurando entorno visual...\e[0m"
mkdir -p "$HOME/Pictures/Wallpapers"
cp "$REPO_ROOT/assets/wallpaper.jpg" "$HOME/Pictures/Wallpapers/" 2>/dev/null

# --- 8. Vinculación de Dotfiles (Nueva Estructura) ---
echo -e "\e[1;34m[*] Desplegando configuraciones desde configs/zsh/...\e[0m"

cp "$REPO_ROOT/configs/zsh/.zshrc" "$HOME/.zshrc"
cp "$REPO_ROOT/configs/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# El fix de Kitty sigue siendo necesario
mkdir -p "$HOME/.terminfo/x"
[ -f "/usr/share/terminfo/x/xterm-kitty" ] && cp /usr/share/terminfo/x/xterm-kitty "$HOME/.terminfo/x/"
