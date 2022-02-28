#!/usr/bin/env bash
# Run as root user in Ubuntu inside Termux
apt-get update -y
package_list=('nemo' 'sudo' 'wget' 'git' 'bash-completion' 'libnotify-bin')
for package in "${package_list[@]}"; do
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
apt-get upgrade -y

#su "${username}"
