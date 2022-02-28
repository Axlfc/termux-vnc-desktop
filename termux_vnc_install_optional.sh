#!/data/data/com.termux/files/usr/bin/env bash
# Install VNC desktop for Android Termux
pkg update -y
package_list=("git" "python3" "openssh" "wget" "x11-repo")
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    pkg install -y"${package}"
  fi
done
rm $PREFIX/etc/apt/sources.list.d/termux-desktop-xfce.list
wget -P $PREFIX/etc/apt/sources.list.d https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/gh-pages/termux-desktop-xfce.list

wget "https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh" && chmod +x setup-audio.sh && ./setup-audio.sh

termux-setup-storage

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

# source $HOME/.config/user-dirs.dirs file in ~/.bashrc

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


ln -s $HOME/storage/music Music

# To install Customizer in Termux Android App
package_list=('wget' 'git' 'bash-completion')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    pkg install -y "${package}"
  fi
done

cd /data/data/com.termux/files/home
git clone https://github.com/AleixMT/Linux-Auto-Customizer
sudo bash Linux-Auto-Customizer/src/core/install.sh -v -o customizer
bash