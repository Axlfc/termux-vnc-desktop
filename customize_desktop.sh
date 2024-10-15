#rm "/data/data/com.termux/files/home/quisoc"
sudo apt-get upgrade -y

#root_customizer_package_list=("nemo" "git" "gitk" "python3" "guake" "tmux" "okular" "vlc" "firefox" "sysmontask" "wireshark" "thunderbird" "pluma" "gpaint" "clonezilla" "screenshots" "gparted" "grsync" "shotwell" "fonts_firacode" "fonts-hack" "fonts-hermit" "fonts-roboto" "inkscape" "gimp" "libreoffice")

root_customizer_package_list=("nemo" "git" "gitk" "python3" "guake" "tmux" "okular" "vlc" "firefox" "sysmontask" "wireshark" "thunderbird" "pluma" "gpaint" "clonezilla" "screenshots" "gparted" "grsync" "shotwell" "systemFonts" "inkscape" "gimp" "libreoffice")
for package in "${root_customizer_package_list[@]}"; do
  sudo customizer-install -v -o -k "${package}"
done

user_customizer_package_list=("prompt" "gitprompt" "history_optimization" "terminal_background" "fastcommands" "bashfunctions" "gitbashfunctions" "shortcuts" "changebg" "bashcolors" "cheat" "converters" "emojis" "templates" "network" "discord" "duckduckgo" "gitcm" "wikipedia" "fonts-lato" "fonts-alegreya_sans" "fonts-noto_sans" "fonts-oswald" "fonts-oxygen" "system_fonts" "telegram")
for package in "${user_customizer_package_list[@]}"; do
  customizer-install -v -o "${package}"
done
