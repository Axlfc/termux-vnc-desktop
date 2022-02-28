#!/usr/bin/env bash
# Run as root user in Ubuntu in Termux
apt-get update -y
package_list=('nemo' 'sudo' 'wget' 'git' 'bash-completion' 'libnotify-bin' 'gedit' 'ubuntu-gnome-desktop' 'gnome-calculator' 'gnome-core' 'gdm3' 'nemo' 'gnome-shell' 'gnome-terminal' 'gnome-screenshot' 'gnome-tweaks' 'gnome-shell-extension-dash-to-panel' 'gnome-tweak-tool')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    apt-get install -y "${package}"
  fi
done

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
    apt-get install -y tigervnc-standalone-server
  fi
fi

if [ -f "/data/data/com.termux/files/home/quisoc" ]; then
  username="$(cat /data/data/com.termux/files/home/quisoc)"
fi

su "${username}"
if whoami == "${username}"; then
  cd /data/data/com.termux/files/home/
  wget "https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh" && chmod +x setup-audio.sh && ./setup-audio.sh

  mkdir -p /data/data/com.termux/files/home/.config

  wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
  chmod +x /data/data/com.termux/files/home/user-dirs.dirs
  mv /data/data/com.termux/files/home/user-dirs.dirs /data/data/com.termux/files/home/.config/user-dirs.dirs

  if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "user-dirs.dirs"; then
    echo "if [ -f /data/data/com.termux/files/home/.config/user-dirs.dirs ]; then
  source /data/data/com.termux/files/home/.config/user-dirs.dirs
fi" >> "/home/${username}/.bashrc"
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

  if [ ! -f /data/data/com.termux/files/home/.vnc/xstartup ]; then
    echo "#!/bin/sh
# Start Gnome 3 Desktop
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r \$HOME/.Xresources ] && xrdb \$HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &
" > /data/data/com.termux/files/home/.vnc/xstartup
  fi
  exit
fi
#rm "/data/data/com.termux/files/home/quisoc"
apt-get upgrade -y

root_customizer_package_list=("nemo" "git" "gitk" "python3" "guake" "tmux" "okular" "vlc" "firefox" "sysmontask" "wireshark" "thunderbird" "pluma" "gpaint" "clonezilla" "screenshots" "gparted" "grsync" "shotwell" "fonts_firacode" "fonts-hack" "fonts-hermit" "fonts-roboto" "inkscape" "gimp" "libreoffice")
for package in "${root_customizer_package_list[@]}"; do
  sudo customizer-install -v -o "${package}"
done

user_customizer_package_list=("prompt" "gitprompt" "history_optimization" "terminal_background" "fastcommands" "bashfunctions" "gitbashfunctions" "shortcuts" "changebg" "bashcolors" "cheat" "converters" "emojis" "templates" "network" "discord" "duckduckgo" "gitcm" "wikipedia" "fonts-lato" "fonts-alegreya_sans" "fonts-noto_sans" "fonts-oswald" "fonts-oxygen" "system_fonts" "telegram")
for package in "${user_customizer_package_list[@]}"; do
  customizer-install -v -o "${package}"
done


