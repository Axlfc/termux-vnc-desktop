#!/data/data/com.termux/files/usr/bin/env bash
# To install ubuntu in Termux Android App

package_list=('iproute2' 'proot' 'wget' 'git')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    apt-get install -y "${package}"
  fi
done

cd $HOME

if [ ! -f /data/data/com.termux/files/home/startubuntu.sh ]; then
  git clone https://github.com/MFDGaming/ubuntu-in-termux.git
  chmod +x ubuntu-in-termux/ubuntu.sh
  ./ubuntu-in-termux/ubuntu.sh -y
fi
if ! "/data/data/com.termux/files/home/quisoc"; then
  echo "$(whoami)" >> "/data/data/com.termux/files/home/quisoc"
fi

if ! cat "/data/data/com.termux/files/home/.bash_aliases" | grep -Fo "alias ubuntu="; then
  echo "alias ubuntu='bash /data/data/com.termux/files/home/startubuntu.sh'" >> "/data/data/com.termux/files/home/.bash_aliases"
fi


if [ -f /data/data/com.termux/files/home/startubuntu.sh ]; then
  echo "Command 'ubuntu' to launch root session"
fi
