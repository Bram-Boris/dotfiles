setxkbmap -layout us -variant intl
setxkbmap -option caps:swapescape
xrdb /home/bram/.Xresources

# Start the keyring daeomon and sock
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
export SSH_AUTH_SOCK

exec i3
exec st
