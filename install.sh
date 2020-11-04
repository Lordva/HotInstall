#!/bin/bash

function BrowserInstall(){
    
    echo "[INFO] note that Firefox is installed by default"
    echo "1. Chrome     4.TOR"
    echo "2. Vivaldi    5. Continue script"
    echo "3. Opera"
    read -r -p "Chose the browser you wish to install: " r
    case $r in
        1) sudo apt install google-chrome-stable & BrowserInstall & BrowserInstall ;;
        2) wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add - && sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' && sudo apt update && sudo apt install vivaldi-stable & BrowserInstall ;;
        3) sudo add-apt-repository 'deb https://deb.opera.com/opera-stable/ stable non-free' && wget -qO - https://deb.opera.com/archive.key | sudo apt-key add - && sudo apt-get update && sudo apt-get install opera-stable & BrowserInstall ;;
        4) sudo add-apt-repository ppa:micahflee/ppa && sudo apt update && sudo apt install torbrowser-launcher & BrowserInstall ;;
        5) return ;;
        *) echo "[ERROR] unexpected argument" & BrowserInstall ;;
    esac
}

echo -e "[LOG] Starting essential install"
if [ "EUID" -ne 0 ]; then
    echo -e "[ERROR] You must be root to run this script"
    exit
fi

if sudo apt update && sudo apt upgrade && flatpak update
then
    echo -e "System update sucessfull"
else
    echo -e "[ERROR] could not update system"
    exit
fi

if sudo apt install snap; then
    echo -e "Snap as been installed"
else
    echo -e "Could not install Snap"
    exit
fi

sudo apt install ubuntu-restricted-extras

sudo apt install gnome-tweaks
BrowserInstall
sudo apt install vlc
flatpak install com.gigitux.gtkwhats
flatpak install com.discordapp.discordapp
flatpak install io.atom.atom
if java -version; then
    echo -e "[LOG] Java is alredy installed"
else
    sudo apt install default-jre && sudo apt install default-jdk
fi
sudo apt install steam
if wine --version; then
    echo "[LOG] Wine is installed"
else
    sudo apt install wine
fi
sudo dpkg --add-architecture i386

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client

sudo apt install neovim


