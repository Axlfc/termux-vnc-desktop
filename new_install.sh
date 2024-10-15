# Install Termux and Termux:API from F-Droid

#apt update -y
#apt upgrade -y
#apt install termux-api

username="$(whoami)"
cd /data/data/com.termux/files/home/

mkdir -p /data/data/com.termux/files/home/.config

wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
chmod +x /data/data/com.termux/files/home/user-dirs.dirs
mv /data/data/com.termux/files/home/user-dirs.dirs /data/data/com.termux/files/home/.config/user-dirs.dirs

touch "/data/data/com.termux/files/home/.profile"

if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "user-dirs.dirs"; then
  echo "if [ -f /data/data/com.termux/files/home/.config/user-dirs.dirs ]; then
  source /data/data/com.termux/files/home/.config/user-dirs.dirs
fi" >> "/data/data/com.termux/files/home/.bashrc"
fi

if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Fo "HOME="; then
  echo "HOME='/data/data/com.termux/files/home'" >> "/home/${username}/.bashrc"
fi

# bash
cd /data/data/com.termux/files/home/
# To install Customizer inside Ubuntu's Sudo-User $HOME folder for the VNC session

git clone https://github.com/AleixMT/Linux-Auto-Customizer
cd Linux-Auto-Customizer
git checkout develop
cd ..
sudo bash Linux-Auto-Customizer/src/core/install.sh -v -o customizer
