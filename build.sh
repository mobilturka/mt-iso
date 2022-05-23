#!/bin/bash
set -e
#### Check root
if [[ ! $UID -eq 0 ]] ; then
    echo -e "\033[31;1mYou must be root!\033[:0m"
    exit 1
fi
#### Remove all environmental variable
for e in $(env | sed "s/=.*//g") ; do
    unset "$e" &>/dev/null
done

#### Set environmental variables
export PATH=/bin:/usr/bin:/sbin:/usr/sbin
export LANG=C
export SHELL=/bin/bash
export TERM=linux
export DEBIAN_FRONTEND=noninteractive

#### Install dependencies
if which apt &>/dev/null && [[ -d /var/lib/dpkg && -d /etc/apt ]] ; then
    apt-get update
    apt-get install curl mtools squashfs-tools grub-pc-bin grub-efi xorriso debootstrap -y
fi

set -ex
#### Chroot create
mkdir chroot || true
apt-get install debootstrap xorriso squashfs-tools mtools grub-pc-bin grub-efi devscripts -y

#debian-chroot dosyası oluşturalım
mkdir debian-chroot
chown root debian-chroot
debootstrap --arch=amd64 sid debian-chroot https://deb.debian.org/debian
for i in dev dev/pts proc sys; do mount -o bind /$i debian-chroot/$i; done

#Debian testing depo ekleyelim
echo 'deb https://deb.debian.org/debian sid main contrib non-free' > debian-chroot/etc/apt/sources.list
chroot debian-chroot apt-get update

#Kernel Grub Live Xorg ve Xinit paketleri kuralım
chroot debian-chroot apt-get install linux-image-amd64 -y
chroot debian-chroot apt-get install grub-pc-bin grub-efi-ia32-bin grub-efi -y
chroot debian-chroot apt-get install live-config live-boot -y 
chroot debian-chroot apt-get install xorg xinit -y

#Firmware paketlerini kuralım (Kurulmasını istemediğiniz firmware paketini silebilirsiniz.)
#chroot debian-chroot apt-get install -y atmel-firmware bluez-firmware dahdi-firmware-nonfree \
  firmware-amd-graphics firmware-ath9k-htc firmware-atheros \
  firmware-b43-installer firmware-b43legacy-installer firmware-bnx2 \
  firmware-bnx2x firmware-brcm80211 firmware-cavium \
  firmware-intel-sound firmware-intelwimax firmware-ipw2x00 \
  firmware-ivtv firmware-iwlwifi firmware-libertas \
  firmware-linux firmware-linux-free firmware-linux-nonfree \
  firmware-misc-nonfree firmware-myricom firmware-netronome \
  firmware-netxen firmware-qcom-soc firmware-qlogic \
  firmware-realtek firmware-samsung firmware-siano \
  firmware-sof-signed firmware-ti-connectivity firmware-zd1211 hdmi2usb-fx2-firmware

chroot debian-chroot apt-get install xfce4 xfce4-goodies parole network-manager-gnome -y
chroot debian-chroot apt-get install blueman gvfs-backends synaptic gdebi firefox firefox-l10n-tr -y

#Gereksiz paketleri silelim
chroot debian-chroot apt-get remove xterm -y

#chroot debian-chroot /bin/bash
umount -lf -R debian-chroot/* 2>/dev/null

#Temizlik işlemleri
chroot debian-chroot apt-get autoremove
chroot debian-chroot apt-get clean
rm -f debian-chroot/root/.bash_history
rm -rf debian-chroot/var/lib/apt/lists/*
find debian-chroot/var/log/ -type f | xargs rm -f

#isowork dizini oluşturma ve shfs alma işlemi
mkdir isowork
mksquashfs debian-chroot filesystem.squashfs -comp gzip -wildcards
mkdir -p isowork/live
mv filesystem.squashfs isowork/live/filesystem.squashfs
cp -pf debian-chroot/boot/initrd.img* isowork/live/initrd.img
cp -pf debian-chroot/boot/vmlinuz* isowork/live/vmlinuz

#iso taslağı oluşturma
mkdir -p isowork/boot/grub/
echo 'insmod all_video' > isowork/boot/grub/grub.cfg
echo 'menuentry "Start Debian Unofficial 64-bit" --class debian {' >> isowork/boot/grub/grub.cfg
echo '    linux /live/vmlinuz boot=live live-config live-media-path=/live --' >> isowork/boot/grub/grub.cfg
echo '    initrd /live/initrd.img' >> isowork/boot/grub/grub.cfg
echo '}' >> isowork/boot/grub/grub.cfg

echo "----------------İso oluşturuluyor..-----------------"
grub-mkrescue isowork -o debian-live-$(date +%x).iso
