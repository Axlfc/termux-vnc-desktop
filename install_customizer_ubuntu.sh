#!/usr/bin/env bash
# To install Customizer inside Ubuntu's User in Termux App

package_list=('wget' 'git' 'gedit' 'bash-completion' 'gnome-calculator')
for package in "${package_list[@]}"; do
  source 
  if ! which "${package}"; then
    apt-get install -y "${package}"
  fi
done

if [ -f "/data/data/com.termux/files/home/quisoc" ]; then
  username="$(cat /data/data/com.termux/files/home/quisoc)"
fi

if whoami == "${username}"; then
  cd $HOME
  mkdir -p $HOME/.config
  wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
  chmod +x $HOME/user-dirs.dirs
  mv $HOME/user-dirs.dirs $HOME/.config/user-dirs.dirs 
  if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "user-dirs.dirs"; then
    echo "if [ -f /data/data/com.termux/files/home/.config/user-dirs.dirs ]; then
  source /data/data/com.termux/files/home/.config/user-dirs.dirs
fi" >> "/home/${username}/.bashrc"
  fi

  if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "HOME="; then
    echo "HOME='/data/data/com.termux/files/home'" >> "/home/${username}/.bashrc"
  fi



  bash
  cd $HOME
  git clone https://github.com/AleixMT/Linux-Auto-Customizer
  sudo bash Linux-Auto-Customizer/src/core/install.sh -v -o customizer; bash
  #rm "/data/data/com.termux/files/home/quisoc"
fi

