#!/bin/sh
set -eu
sudo pacman -S --needed base-devel linux419-headers 
make
lsmod | grep -q 8812au || sudo insmod 8812au.ko
rm -f 8812au.ko.xz
xz 8812au.ko
DEST_DIR=/lib/modules/$(uname -r)/kernel/drivers/net/wireless/realtek/rtlwifi/rtl8812au
sudo mkdir -p $DEST_DIR
sudo cp 8812au.ko.xz $DEST_DIR
echo 8812au |sudo tee /etc/modules-load.d/rtl8812au.conf
