#! /bin/sh
#
if [ $1 = "" ]
then
	DISTRO_NAME=my_distro-iso
	DISTRO=my_distro
else
	DISTRO_NAME=$1'-iso'
	DISTRO=$1
fi
echo $DISTRO_NAME
if [ $2 = "-f" ]
then
	sudo rm -r $DISTRO_NAME
	mkdir $DISTRO_NAME
	cd $DISTRO_NAME
	sudo lb init
else
	cd $DISTRO_NAME
fi
# clean up the configuration
sudo lb clean
# pre-configure the base system
sudo lb config ­-b iso --cache true --apt-recommends --distribution wheezy true -a amd64  --linux-flavour=3.14-1-amd64 --binary-images iso ­­--debian-installer live --mode debian ­--debian­-installer-gui false ­­--archive-areas "main" ­­--security true --win32-loader false ­­--updates true
# remove old temporary files
rm ../$DISTRO.8.list.chroot ../$DISTRO.7.list.chroot ../$DISTRO.6.list.chroot ../$DISTRO.5.list.chroot ../$DISTRO.4.list.chroot ../$DISTRO.3.list.chroot ../$DISTRO.2.list.chroot ../$DISTRO.1.list.chroot ../$DISTRO.0.list.chroot ../$DISTRO.t.list.chroot ../$DISTRO.list.chroot
dpkg --get-selections > ../$DISTRO.8.list.chroot
# cleanup application list
awk '{gsub("	deinstall", "");print}' ../$DISTRO.8.list.chroot >> ../$DISTRO.7.list.chroot
awk '{gsub("	install", "");print}' ../$DISTRO.7.list.chroot >> ../$DISTRO.6.list.chroot
# special cleanup rules
awk '{gsub("cjdns	", "");print}' ../$DISTRO.6.list.chroot >> ../$DISTRO.5.list.chroot
awk '{gsub("cjdns-dbg	", "");print}' ../$DISTRO.5.list.chroot >> ../$DISTRO.4.list.chroot
awk '{gsub("pidgin-gnome-keyring	", "");print}' ../$DISTRO.4.list.chroot >> ../$DISTRO.3.list.chroot
#awk '{gsub("linux-image-3.2.0-4-amd64	","");print}' ../$DISTRO.3.list.chroot >> ../$DISTRO.2.list.chroot
#awk '{gsub("linux-image-3.14-0.bpo.1-amd64	","");print}' ../$DISTRO.2.list.chroot >> ../$DISTRO.1.list.chroot
#awk '{gsub("linux-image-3.14-0.bpo.1-amd64	","");print}' ../$DISTRO.1.list.chroot >> ../$DISTRO.0.list.chroot
#awk '{gsub("linux-image-3.14-1-amd64	","");print}' ../$DISTRO.0.list.chroot >> ../$DISTRO.t.list.chroot
#awk '{gsub("linux-image-amd64	","");print}' ../$DISTRO.t.list.chroot >> ../$DISTRO.list.chroot
rm ../$DISTRO.8.list.chroot ../$DISTRO.7.list.chroot ../$DISTRO.6.list.chroot ../$DISTRO.5.list.chroot ../$DISTRO.4.list.chroot ../$DISTRO.3.list.chroot ../$DISTRO.2.list.chroot ../$DISTRO.1.list.chroot ../$DISTRO.0.list.chroot ../$DISTRO.t.list.chroot
sudo rm config/packages.chroot/pidgin-gnome-keyring_1.18-1_amd64.deb config/packages.chroot/cjdns_0.7_amd64.deb config/packages.chroot/cjdns-dbg_0.7_amd64.deb
# these will eventually be replaced by hosting a custom debian repository mirror
sudo cp ../$DISTRO.list.chroot config/package-lists/$DISTRO.list.chroot
sudo mv ../.cjdns/cjdns_0.7_amd64.deb config/packages.chroot/cjdns_0.7_amd64.deb
sudo mv ../.cjdns/cjdns-dbg_0.7_amd64.deb config/packages.chroot/cjdns-dbg_0.7_amd64.deb
wget -O pidgin-gnome-keyring.deb https://pidgin-gnome-keyring.googlecode.com/files/pidgin-gnome-keyring_1.18-1_amd64.deb
sudo mv pidgin-gnome-keyring_1.18-1_amd64.deb config/packages.chroot/pidgin-gnome-keyring_1.18-1_amd64.deb
#cat ../$DISTRO.list.chroot
# copying base system sources.list
echo "cat /etc/apt/sources.list > config/archives/$DISTRO.list.chroot" | sudo bash
# importing Tor keys
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 > ../tor.key.chroot
sudo mv ../tor.key.chroot config/archives/tor.key.chroot
# copying base system sources.list
echo "cat /etc/apt/preferences >> config/archives/$DISTRO.pref.chroot" | sudo bash
# sudo lb build
