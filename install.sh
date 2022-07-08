#!/bin/bash

CFG_PATH=~/.config/duchy-dotfiles
INSTALL_PATH=~/install


sudo apt-get update
sudo apt-get upgrade

sudo apt-get install libxrandr-dev libxinerama-dev pkg-config libxft-dev python3-pip gnupg2 firefox-esr linux-headers-$(uname -r) xorg ripgrep nmap hexcurse build-essential make cmake automake git curl wget zsh tmux ranger zathura mpv transmission-gtk transmission-cli tor libx11-dev neovim

git config --global user.name "duchy"
git config --global user.email "duchy@honeypot.lol"

echo "export CFG_PATH=$CFG_PATH" >> cfg/zsh.conf
echo "export INSTALL_PATH=$INSTALL_PATH" >> cfg/zsh.conf

mkdir -p $CFG_PATH
cp cfg/*.conf $CFG_PATH

mkdir -p $INSTALL_PATH
cd $INSTALL_PATH

git clone https://git.suckless.org/st
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/slock
git clone https://git.suckless.org/dmenu

for x in *; do
	cd $x
	git checkout -b duchy
	cp $CFG_PATH/$x.conf config.def.h
	make && sudo make install
	cd ..
done

cd $INSTALL_PATH

git clone https://github.com/lwfinger/rtw89
cd rtw89
make
sudo make install
cd ~/

cp $CFG_PATH/zsh.conf ~/.zshrc
mkdir -p ~/.config/nvim
cp $CFG_PATH/tmux.conf ~/.config/tmux.conf
cp $CFG_PATH/nvim.conf ~/.config/nvim/init.vim
sudo cp $CFG_PATH/touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
cat /etc/default/grub | sed -e "s/GRUB_CMDLINE_LINUX=\".*/GRUB_CMDLINE_LINUX\=\"net.ifnames=0\"/" | sudo tee /etc/default/grub
sudo update-grub
echo "exec dwm" > ~/.xinitrc
