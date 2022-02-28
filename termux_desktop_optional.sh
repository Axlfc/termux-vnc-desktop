#!/data/data/com.termux/files/usr/bin/env bash
# Install VNC desktop for Android Termux
pkg update -y
package_list=("git" "python3" "openssh" "wget" "x11-repo" "bash-completion")
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    pkg install -y "${package}"
  fi
done
rm $PREFIX/etc/apt/sources.list.d/termux-desktop-xfce.list
wget -P $PREFIX/etc/apt/sources.list.d https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/gh-pages/termux-desktop-xfce.list

wget "https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh" && chmod +x setup-audio.sh && ./setup-audio.sh

termux-setup-storage

apt-get update -y
package_list=("xfce4" "tigervnc" "xfce4-goodies" "termux-desktop-xfce" "breeze-cursor-theme" "kvantum" "ttf-microsoft-cascadia" "audacious" "leafpad" "pavucontrol-qt" "geany" "otter-browser" "leafpad")
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    pkg install -y"${package}"
  fi
done
apt-get upgrade -y

cd /data/data/com.termux/files/home/
wget https://github.com/Yisus7u7/termux-desktop-xfce/releases/download/desktop-5.0.3/data.tar.xz
tar -xvf data.tar.xz
rm data.tar.xz

mkdir -p /data/data/com.termux/files/home/.config
wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
chmod +x /data/data/com.termux/files/home/user-dirs.dirs
mv /data/data/com.termux/files/home/user-dirs.dirs /data/data/com.termux/files/home/.config/user-dirs.dirs

mkdir -p /data/data/com.termux/files/home/Desktop
mkdir -p /data/data/com.termux/files/home/Downloads
mkdir -p /data/data/com.termux/files/home/Templates
mkdir -p /data/data/com.termux/files/home/Public
mkdir -p /data/data/com.termux/files/home/Documents
mkdir -p /data/data/com.termux/files/home/Pictures
mkdir -p /data/data/com.termux/files/home/Videos

ln -s /data/data/com.termux/files/home/storage/music Music


if ! cat "/data/data/com.termux/files/home/.bashrc" | grep -Eo "export DISPLAY=:1"; then
	echo "export DISPLAY=:1" >> "/data/data/com.termux/files/home/.bashrc"
fi


# To install Customizer in Termux Android App
cd /data/data/com.termux/files/home
git clone https://github.com/AleixMT/Linux-Auto-Customizer
sudo bash Linux-Auto-Customizer/src/core/install.sh -v -o customizer
bash
