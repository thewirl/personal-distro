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
# copying base system sources.list
sudo cp ../sources.list.chroot config/archives/$DISTRO.list.chroot
# copying base system live.list
sudo cp ../live.list.chroot config/package-lists/$DISTRO.list.chroot
# copying base system apt preferences
sudo cp ../preferences.list.chroot config/archives/$DISTRO.pref.chroot
# importing Tor keys
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 > ../tor.key.chroot
sudo mv ../tor.key.chroot config/archives/tor.key.chroot
sudo lb build
