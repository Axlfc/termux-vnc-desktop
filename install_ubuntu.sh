#!/data/data/com.termux/files/usr/bin/env bash
# To install Ubuntu in Termux Android App

package_list=('iproute2' 'proot' 'wget' 'git')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    pkg "${package}"
  fi
done

cd /data/data/com.termux/files/home

if [ ! -f /data/data/com.termux/files/home/startubuntu.sh ]; then
  git clone https://github.com/MFDGaming/ubuntu-in-termux.git
  chmod +x ubuntu-in-termux/ubuntu.sh
  ./ubuntu-in-termux/ubuntu.sh -y
fi
if [ ! -f "/data/data/com.termux/files/home/quisoc" ]; then
  echo "$(whoami)" > "/data/data/com.termux/files/home/quisoc"
fi

if [ -f "/data/data/com.termux/files/home/.bash_aliases" ]; then
  if ! cat "/data/data/com.termux/files/home/.bash_aliases" | grep -Fqo "alias ubuntu="; then
    echo "alias ubuntu='bash /data/data/com.termux/files/home/startubuntu.sh'" >> "/data/data/com.termux/files/home/.bash_aliases"
  fi
fi
