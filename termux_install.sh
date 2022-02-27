#!/data/data/com.termux/files/usr/bin/env bash
# Install VNC desktop for Android Termux
apt-get install -y git python3 openssh wget x11-repo

rm $PREFIX/etc/apt/sources.list.d/termux-desktop-xfce.list
wget -P $PREFIX/etc/apt/sources.list.d https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/gh-pages/termux-desktop-xfce.list

apt-get update -y

apt-get install -y xfce4 tigervnc xfce4-goodies termux-desktop-xfce breeze-cursor-theme kvantum ttf-microsoft-cascadia audacious leafpad pavucontrol-qt geany otter-browser leafpad

apt-get upgrade -y
cd $HOME
wget https://github.com/Yisus7u7/termux-desktop-xfce/releases/download/desktop-5.0.3/data.tar.xz
tar -xvf data.tar.xz
rm data.tar.xz

mkdir -p $HOME/.config
wget -L https://Yisus7u7.github.io/mirrors/scripts/user-dirs.dirs
chmod +x $HOME/user-dirs.dirs 
mv $HOME/user-dirs.dirs $HOME/.config/user-dirs.dirs


mkdir -p $HOME/Desktop
mkdir -p $HOME/Downloads
mkdir -p $HOME/Templates
mkdir -p $HOME/Public
mkdir -p $HOME/Documents
mkdir -p $HOME/Pictures
mkdir -p $HOME/Videos

if ! cat "$HOME/.bashrc" | grep -Eo "export DISPLAY=:1"; then 
	echo "export DISPLAY=:1" >> "$HOME/.bashrc"
fi

termux-setup-storage
ln -s $HOME/storage/music Music
