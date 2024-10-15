sudo systemctl enable gdm
sudo systemctl start gdm

mkdir -p /data/data/com.termux/files/home/.vnc
if [ ! -f /data/data/com.termux/files/home/.vnc/xstartup ]; then
touch /data/data/com.termux/files/home/.vnc/xstartup
  # cp /data/data/com.termux/files/home/.vnc/xstartup /data/data/com.termux/files/home/.vnc/xstartup.bak
  xstartup_text='#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
export XDG_MENU_PREFIX="gnome-flashback-"

# Start Gnome 3 Desktop
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
gnome-terminal &

dbus-launch --exit-with-session gnome-session --builtin --session=gnome-flashback-metacity --disable-acceleration-check --debug &
mate-session
'
  echo "${xstartup_text}" > /data/data/com.termux/files/home/.vnc/xstartup
  sudo chmod +x /data/data/com.termux/files/home/.vnc/xstartup
fi
