#!/bin/bash
# Detecta la IP activa sin importar el nombre de la interfaz (ens33/eth0/wlan0)
ip_active=$(ip route get 1.1.1.1 2>/dev/null | grep -Po '(?<=src )(\d{1,3}.){3}\d{1,3}')
tun0=$(ip addr show tun0 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1)

if [ -n "$tun0" ]; then
    echo "%{F#9ece6a}󰆧 %{F#ffffff}$tun0"
else
    echo "%{F#2495e7}󰈀 %{F#ffffff}${ip_active:-"Disconnected"}"
fi
