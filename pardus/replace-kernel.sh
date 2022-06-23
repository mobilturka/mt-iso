echo "deb http://depo.pardus.org.tr/backports yirmibir-backports main contrib non-free" > /etc/apt/sources.list.d/yirmibir-backports.list
apt update -y
apt install -t yirmibir-backports linux-image-amd64 linux-headers-amd64 -y
