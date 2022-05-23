echo "deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list.d/sid.list
apt-get update -y
apt-get install gnome-session gnome-shell gnome-applets gnome-control-center mutter gjs adwaita-icon-theme -y
apt-get install linux-image-amd64 -y
echo "#deb https://deb.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list.d/sid.list
apt-get update -y
