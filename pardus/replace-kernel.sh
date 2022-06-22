echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" > /etc/apt/sources.list.d/bullseye-backports.list
apt update -y
apt install -t bullseye-backports linux-image-amd64 -y
