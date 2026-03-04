#!/bin/bash
# --- Phoenix Architecture: Sincronizador Local -> Repo ---

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\e[1;32m[*] Sincronizando configuraciones actuales hacia el repositorio...\e[0m"

# 1. Configs (bspwm, polybar, etc)
cp -r ~/.config/bspwm/* "$REPO_DIR/configs/bspwm/"
cp -r ~/.config/polybar/* "$REPO_DIR/configs/polybar/"
cp -r ~/.config/sxhkd/* "$REPO_DIR/configs/sxhkd/"
cp -r ~/.config/kitty/* "$REPO_DIR/configs/kitty/"
cp -r ~/.config/picom/* "$REPO_DIR/configs/picom/"

# 2. Dotfiles base (Zsh y P10k)
cp ~/.zshrc "$REPO_DIR/configs/zshrc"
cp ~/.p10k.zsh "$REPO_DIR/configs/p10k.zsh"

# 3. Scripts de red e inteligencia
cp ~/.config/bspwm/scripts/*.sh "$REPO_DIR/scripts/"

echo -e "\e[1;34m[+] Sincronización completada. Archivos listos en $REPO_DIR\e[0m"
