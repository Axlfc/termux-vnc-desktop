#!/usr/bin/env bash
# Run as root user in Ubuntu in Termux
apt-get update -y
package_list=('dialog' 'nemo' 'nano' 'sudo' 'wget' 'git' 'pulseaudio' 'bash-completion' 'dbus-x11' 'compiz' 'compizconfig-settings-manager' 'libnotify-bin' 'gedit' 'ubuntu-gnome-desktop' 'gnome-calculator' 'gnome-core' 'gdm3' 'gnome-shell' 'gnome-terminal' 'gnome-screenshot' 'gnome-tweaks' 'gnome-shell-extension-dash-to-panel' 'gnome-tweak-tool' 'mate-desktop' 'net-tools' 'iputils-ping' 'xfonts-75dpi' 'xfonts-100dpi' 'fonts-symbola' 'metacity' 'gnome-panel')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    apt-get install -y "${package}"
  fi
done

apt-get purge -y network-manager

#pulseaudio (*alsa) 
#OUTPUT: OK
#INPUT: ?

## Fix Nameserver 
if [ ! -f /etc/resolv.conf ]; then
  echo "nameserver 1.1.1.1" > /etc/resolv.conf
fi

# change ubuntu's hostname, it is not 'localhost' it will instead be 'ubuntu-termux'
# Edit /etc/hostname File
if [ ! -f /etc/hostname ]; then
  echo "ubuntu-termux" > /etc/hostname
fi

# Edit Your /etc/hosts
if [ ! -f /etc/hosts ]; then
  echo "127.0.0.1 localhost
127.0.1.1 ubuntu-termux" > /etc/hosts
fi


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
  echo "export DISPLAY=\"${ip_adresses}:0\"" >> /etc/bash.bashrc
    fi
else
  if ! which vncserver; then
    apt-get install -y tightvncserver
    ip_adresses="$(ip a | grep -Eo "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | cut -d " " -f2 | tail -1)"
    echo "export DISPLAY=\"${ip_adresses}:0\"" >> /etc/bash.bashrc
  fi
fi

echo "export XDG_SESSION_DESKTOP=gnome" >> /etc/bash.bashrc
echo "export DESKTOP_SESSION=gnome" >> /etc/bash.bashrc

su "${username}"
