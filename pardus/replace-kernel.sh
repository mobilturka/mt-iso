echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list
apt update -y
apt install -t backports linux-image-amd64 -y
