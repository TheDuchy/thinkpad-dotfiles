#!/bin/bash

cd /tmp

sudo apt-get install linux-headers-$(uname -r)

wget https://www.openwall.com/signatures/openwall-offline-signatures.asc
gpg --import openwall-offline-signatures.asc
wget https://lkrg.org/download/lkrg-0.9.3.tar.gz
wget https://lkrg.org/download/lkrg-0.9.3.tar.gz.sign
gpg --verify lkrg-0.9.3.tar.gz.sign lkrg-0.9.3.tar.gz

if ! [[ $? -eq 0 ]]; then
	echo "Signature invalid"
	exit 1
fi

tar -zxvf lkrg-0.9.3.tar.gz
cd lkrg-0.9.3/

make -j$(nproc)
sudo make install
sudo systemctl enable lkrg
sudo systemctl start lkrg
