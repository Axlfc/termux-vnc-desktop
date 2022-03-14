#!/usr/bin/env bash
# Run as root user in Ubuntu in Termux
apt-get update -y
package_list=('dialog' 'nemo' 'nano' 'sudo' 'wget' 'git' 'bash-completion' 'libnotify-bin' 'gedit' 'ubuntu-gnome-desktop' 'gnome-calculator' 'gnome-core' 'gdm3' 'gnome-shell' 'gnome-terminal' 'gnome-screenshot' 'gnome-tweaks' 'gnome-shell-extension-dash-to-panel' 'gnome-tweak-tool')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    apt-get install -y "${package}"
  fi
done

apt-get purge -y network-manager
## Fix Nameserver 
echo "nameserver 1.1.1.1" > /etc/resolv.conf


if [ -f "/data/data/com.termux/files/home/quisoc" ]; then
  username="$(cat /data/data/com.termux/files/home/quisoc)"
else
  username="android"
fi

adduser "${username}"
usermod -aG sudo "${username}"
echo "${username}  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/${username}

if [ -d /data/data/com.termux/files/home/.vnc ]; then
  if ! cat /etc/bash.bashrc | grep 'export DISPLAY='; then
  ip_adresses="$(ip a | grep -Eo "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | cut -d " " -f2 | tail -1)"
  echo "export DISPLAY=\"${ip_adresses}:1\"" >> /etc/bash.bashrc
  fi
else
  if ! which vncserver; then
    apt-get install -y tightvncserver
    ip_adresses="$(ip a | grep -Eo "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | cut -d " " -f2 | tail -1)"
    echo "export DISPLAY=\"${ip_adresses}:1\"" >> /etc/bash.bashrc
  fi
fi

su "${username}"
username="$(whoami)"
cd /data/data/com.termux/files/home/

mkdir -p /data/data/com.termux/files/home/.config

wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
chmod +x /data/data/com.termux/files/home/user-dirs.dirs
mv /data/data/com.termux/files/home/user-dirs.dirs /data/data/com.termux/files/home/.config/user-dirs.dirs

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
  cp /data/data/com.termux/files/home/.vnc/xstartup /data/data/com.termux/files/home/.vnc/xstartup.bak
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


