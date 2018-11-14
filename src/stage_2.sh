## Stage 2

# 1. Base system installation

debootstrap \
    --exclude="${EXCLUDE_PKGS_FROM_INSTALLATION}" \
    --arch "${TRISQUEL_ARCH}" \
    "${TRISQUEL_VERSION}" \
    "${TARGET}" \
    "${TRISQUEL_MIRROR}"

# 2. Copy all files

#for f in ${FD}; do
#
#done
#cp -aR "${FILES_DIRECTORY}" 

# 3. Chroot

LANG=C.UTF-8 chroot "${TARGET}" /bin/bash

# 4. makedev

apt-get install makedev
mount none /proc -t proc
# Check /dev TODO

# 5. genfstab

cd /
./genfstab -U / >> /etc/fstab

# 6. Timezone FIXME. Find an automatic way to do it.

dpkg-reconfigure tzdata

# 7. Network configuration
# 8. APT FIXME
#
#    Add missing entries in `/etc/apt/sources.list`

# 9. Locales, language, kemap FIXME
# cp then gen

if [ -f '/etc/locale.gen' ]; then
    locale-gen
fi

#    /etc/default/keyboard: 
#```
    # KEYBOARD CONFIGURATION FILE
    # Consult the keyboard(5) manual page.

#    XKBMODEL="pc105"
#    XKBLAYOUT="it"
#    XKBVARIANT=""
#    XKBOPTIONS=""

#    BACKSPACE="guess"
#```

# 9. Install the kernel. FIXME: set a generic version.

apt-get install linux-image-4.4.0-34-generic linux-image-extra-4.4.0-34-generic

# 10. Install the bootloader

apt-get install extlinux gdisk
./syslinux-install_update -iam

# 11. root password

passwd
