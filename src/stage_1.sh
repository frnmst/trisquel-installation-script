## Stage 1

apt-get update
apt-get install git m4 make
mkdir "${BUILD_DIRECTORY}"
cd "${BUILD_DIRECTORY}"
git clone https://git.archlinux.org/arch-install-scripts.git

if [ "${BOOTLOADER}" = 'EXTLINUX' ]; then
    wget https://git.parabola.nu/abslibre.git/plain/libre/syslinux/syslinux-install_update
    # Apply the syslinux-install_update.patch TODO
fi
