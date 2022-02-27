#!/usr/bin/env bash
# To install Customizer inside Ubuntu's Sudo-User VNC session running in Android Termux App

package_list=('wget' 'git' 'gedit' 'bash-completion' 'gnome-calculator' 'gnome-core' 'gdm3' 'nemo' 'gnome-shell' 'gnome-terminal' 'gnome-screenshot' 'libnotify-bin' 'gnome-tweaks' 'gnome-shell-extension-dash-to-panel' 'gnome-tweak-tool' 'bash-completion')
for package in "${package_list[@]}"; do
  if ! which "${package}"; then
    sudo apt-get install -y "${package}"
  fi
done

# Proceed with Ubuntu VNC Server installation
# --tigervnc-standalone-server
if ! which vncserver; then
  sudo apt install -y tigervnc-standalone-server
fi