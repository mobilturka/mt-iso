apt update
apt install wget bzip2 zenity -y
apt full-upgrade -y
apt purge libreoffice-common -y
apt remove gdebi packagekit pardus-java-installer evolution-common evolution-data-server-common xterm xfce4-sensors-plugin vlc xarchiver -y
apt remove firefox-esr audacious audacious-plugins-data drawing firefox-esr gimp gimp-data -y
apt install librewolf -y
apt autoremove -y
