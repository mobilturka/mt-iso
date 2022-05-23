apt update
apt install wget bzip2 zenity -y
apt full-upgrade -y
apt remove termit xterm icedtea-netx -y
apt autoremove -y
echo 'deb https://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list.d/sid.list
apt update
apt -t sid install gnome-session gnome-shell gnome-applets gnome-control-center mutter gjs adwaita-icon-theme -y
echo '#deb https://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list.d/sid.list
apt update
apt autoremove -y


