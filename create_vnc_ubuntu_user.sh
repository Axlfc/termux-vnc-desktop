#!/usr/bin/env bash
# Run as root user in Ubuntu inside Termux

package_list=('nemo' 'sudo' 'wget' 'git' 'bash-completion' 'libnotify-bin')
for package in "${package_list[@]}"; do
  source 
  if ! which "${package}"; then
    apt-get install -y "${package}"
  fi
done

if [ -f "/data/data/com.termux/files/home/quisoc" ]; then
  username="$(cat /data/data/com.termux/files/home/quisoc)"
fi

adduser "${username}"
usermod -aG sudo "${username}"
echo "${username}  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/${username}

if ! cat /etc/bash.bashrc | grep 'export DISPLAY='; then
  echo "export DISPLAY=\"$(ip a | grep 'inet ' | grep 'wlan0' | cut -d '/' -f1 | rev | cut -d ' ' -f1 | rev):1\"" >> /etc/bash.bashrc
fi

#su "${username}"
