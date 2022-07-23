echo "deb http://depo.pardus.org.tr/backports yirmibir-backports main contrib non-free" > /etc/apt/sources.list.d/yirmibir-backports.list
echo "deb http://deb.debian.org/debian testing main contrib non-free" > /etc/apt/sources.list.d/testing.list
apt update -y
apt install -t testing linux-image-amd64 -y
apt install -t testing '?upgradable ?source-package("mesa|libdrm")' -y
echo "#deb http://deb.debian.org/debian testing main contrib non-free" > /etc/apt/sources.list.d/testing.list
apt update -y
