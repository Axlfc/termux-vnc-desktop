#!/data/data/com.termux/files/usr/bin/env bash
if ! which wget 
	apt-get install -y wget
elif ! which git
	apt-get install -y git
elif ! which proot
apt-get install -y proot
fi

cd $HOME
git clone https://github.com/MFDGaming/ubuntu-in-termux.git
chmod +x ubuntu-in-termux/ubuntu.sh
./ubuntu-in-termux/ubuntu.sh -y
