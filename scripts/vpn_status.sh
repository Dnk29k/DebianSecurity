#!/bin/bash

# --- Colores (Paleta TokyoNight/Macbook-Debian) ---
COLOR_HTB="%{F#9ece6a}"   # Verde
COLOR_NORD="%{F#7dcfff}"  # Azul
COLOR_OFF="%{F#f7768e}"   # Rojo/Rosa
COLOR_TEXT="%{F#ffffff}"
RESET="%{F-}"

# 1. Detectar Hack The Box (tun0)
ip_htb=$(ip -o -4 addr show tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1)

if [ -n "$ip_htb" ]; then
    echo "${COLOR_HTB}󰆧 ${COLOR_TEXT}$ip_htb${RESET}"
    exit 0
fi

# 2. Detectar NordVPN (nordlynx es el protocolo moderno de Nord)
ip_nord=$(ip -o -4 addr show nordlynx 2>/dev/null | awk '{print $4}' | cut -d/ -f1)

# Si no encuentra nordlynx, busca tun1 (protocolo OpenVPN de Nord)
if [ -z "$ip_nord" ]; then
    ip_nord=$(ip -o -4 addr show tun1 2>/dev/null | awk '{print $4}' | cut -d/ -f1)
fi

if [ -n "$ip_nord" ]; then
    echo "${COLOR_NORD} ${COLOR_TEXT}$ip_nord${RESET}"
    exit 0
fi

# 3. Estado Desconectado
echo "${COLOR_OFF}󰆧 ${COLOR_TEXT}Disconnected${RESET}"
