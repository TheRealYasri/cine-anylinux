#!/bin/sh
set -eu
ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
sudo pacman -Syy --noconfirm archlinux-keyring
#Make
sudo pacman -S --noconfirm --needed git base-devel blueprint-compiler meson 
#Needed
sudo pacman -S --noconfirm --needed gtk4 libadwaita mpv python-gobject python-mpv python-pip


echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano


echo "Installing masterkey from source packages..."
echo "---------------------------------------------------------------"
git clone https://github.com/diegopvlk/Cine.git

cd Cine
meson setup build --prefix=/usr
meson compile -C build
sudo meson install -C build
cd ..

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
