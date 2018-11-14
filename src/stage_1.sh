## Stage 1

apt-get update
apt-get install git m4 make
mkdir /build
cd build
git clone https://git.archlinux.org/arch-install-scripts.git
wget https://git.parabola.nu/abslibre.git/plain/libre/syslinux/syslinux-install_update
# Apply the syslinux-install_update.patch TODO
