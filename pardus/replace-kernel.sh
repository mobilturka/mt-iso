wget -O - https://liquorix.net/liquorix-keyring.gpg | apt-key add -
echo "deb http://liquorix.net/debian stable main" > /etc/apt/sources.list.d/liquorix.list
apt-get update -y
apt-get install linux-image-liquorix-amd64 -y
apt-get install linux-headers-liquorix-amd64 -y
echo "deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list.d/sid.list
apt-get update -y
apt-get install gnome-session gnome-shell gnome-applets gnome-control-center mutter gjs adwaita-icon-theme -y
echo "#deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list.d/sid.list
apt-get update -y
