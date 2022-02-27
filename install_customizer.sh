#!/data/data/com.termux/files/usr/bin/env bash
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