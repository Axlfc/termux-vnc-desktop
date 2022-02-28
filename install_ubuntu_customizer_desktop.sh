#!/usr/bin/env bash
# To install Customizer inside Ubuntu's User session in Termux App

if [ -f "/data/data/com.termux/files/home/quisoc" ]; then
  username="$(cat /data/data/com.termux/files/home/quisoc)"
fi
su "${username}"

if whoami == "${username}"; then
  sudo apt-get update -y
  package_list=('wget' 'git' 'gedit' 'bash-completion' 'ubuntu-gnome-desktop' 'gnome-calculator' 'gnome-core' 'gdm3' 'nemo' 'gnome-shell' 'gnome-terminal' 'gnome-screenshot' 'libnotify-bin' 'gnome-tweaks' 'gnome-shell-extension-dash-to-panel' 'gnome-tweak-tool' 'bash-completion')
  for package in "${package_list[@]}"; do
    if ! which "${package}"; then
      sudo apt-get install -y "${package}"
    fi
  done

  cd /data/data/com.termux/files/home/
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
  #rm "/data/data/com.termux/files/home/quisoc"

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

  sudo apt-get upgrade -y
fi