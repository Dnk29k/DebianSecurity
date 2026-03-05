# Ejemplo de lo que debería ir en configs/xinitrc
sxhkd &
python3 $HOME/.config/polybar/launch.sh &
feh --bg-fill $HOME/DebianSecurity/assets/wallpaper.jpg &
exec bspwm
