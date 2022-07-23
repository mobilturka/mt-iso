echo "deb http://depo.pardus.org.tr/backports yirmibir-backports main contrib non-free" > /etc/apt/sources.list.d/yirmibir-backports.list
echo "deb http://deb.debian.org/debian testing main contrib non-free" > /etc/apt/sources.list.d/testing.list
apt update -y
apt install -t testing linux-image-amd64 linux-headers-amd64 -y
apt install -t testing firmware-amd-graphics libdrm-amdgpu1 xserver-xorg-video-amdgpu xserver-xorg-video-intel xserver-xorg-video-ati xserver-xorg-video-radeon xserver-xorg-video-all -y
apt install -t testing '?upgradable ?source-package("mesa|libdrm")' -y
apt update -y
