# Install Termux and Termux:API from F-Droid

#apt update -y
#apt upgrade -y
#apt install termux-api

username="$(whoami)"
cd /data/data/com.termux/files/home/

mkdir -p /data/data/com.termux/files/home/.config

wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
chmod +x /data/data/com.termux/files/home/user-dirs.dirs
mv /data/data/com.termux/files/home/user-dirs.dirs /data/data/com.termux/files/home/.config/user-dirs.dirs

touch "/data/data/com.termux/files/home/.profile"

if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "user-dirs.dirs"; then
  echo "if [ -f /data/data/com.termux/files/home/.config/user-dirs.dirs ]; then
  source /data/data/com.termux/files/home/.config/user-dirs.dirs
fi" >> "/data/data/com.termux/files/home/.bashrc"
fi

if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "HOME="; then
  echo "HOME='/data/data/com.termux/files/home'" >> "/home/${username}/.bashrc"
fi

bash
cd /data/data/com.termux/files/home/
# To install Customizer inside Ubuntu's Sudo-User $HOME folder for the VNC session

git clone https://github.com/AleixMT/Linux-Auto-Customizer
sudo bash Linux-Auto-Customizer/src/core/install.sh -v -o customizer; bash

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
exit

#rm "/data/data/com.termux/files/home/quisoc"
apt-get upgrade -y

root_customizer_package_list=("nemo" "git" "gitk" "python3" "guake" "tmux" "okular" "vlc" "firefox" "sysmontask" "wireshark" "thunderbird" "pluma" "gpaint" "clonezilla" "screenshots" "gparted" "grsync" "shotwell" "fonts_firacode" "fonts-hack" "fonts-hermit" "fonts-roboto" "inkscape" "gimp" "libreoffice")
for package in "${root_customizer_package_list[@]}"; do
  sudo customizer-install -v -o -k "${package}"
done

user_customizer_package_list=("prompt" "gitprompt" "history_optimization" "terminal_background" "fastcommands" "bashfunctions" "gitbashfunctions" "shortcuts" "changebg" "bashcolors" "cheat" "converters" "emojis" "templates" "network" "discord" "duckduckgo" "gitcm" "wikipedia" "fonts-lato" "fonts-alegreya_sans" "fonts-noto_sans" "fonts-oswald" "fonts-oxygen" "system_fonts" "telegram")
for package in "${user_customizer_package_list[@]}"; do
  customizer-install -v -o "${package}"
done
