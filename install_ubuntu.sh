#!/data/data/com.termux/files/usr/bin/env bash
# To install Ubuntu in Termux Android App
pkg update -y
package_list=("iproute2" "proot" "wget" "git" "proot-distro" "bash" "bzip2" "coreutils" "curl" "findutils" "gzip" "dnsutils" "ncurses-utils" "sed" "tar" "xz-utils")
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    pkg install -y "${package}"
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

touch "/data/data/com.termux/files/home/.bash_aliases"
if [ -f "/data/data/com.termux/files/home/.bash_aliases" ]; then
  if ! cat "/data/data/com.termux/files/home/.bash_aliases" | grep -Fqo "alias ubuntu="; then
    echo "alias ubuntu='bash /data/data/com.termux/files/home/startubuntu.sh'" >> "/data/data/com.termux/files/home/.bash_aliases"
  fi
fi

if [ ! -f "/data/data/com.termux/files/home/.bashrc" ]; then
  touch "/data/data/com.termux/files/home/.bashrc"
  if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fqo "source /data/data/com.termux/files/home/.bash_aliases"; then
    echo "source /data/data/com.termux/files/home/.bash_aliases" >> "/data/data/com.termux/files/home/.bash_aliases"
  fi
fi
