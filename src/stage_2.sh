## Stage 2

#
# 1. Base system installation
#

debootstrap \
    --exclude="${EXCLUDE_PKGS_FROM_INSTALLATION}" \
    --arch "${TRISQUEL_ARCH}" \
    "${TRISQUEL_VERSION}" \
    "${TARGET}" \
    "${TRISQUEL_MIRROR}"

#
# 2. Generate fstab.
#

# This is possibly overridden by sub-stage 3.
"${BUILD_DIRECTORY}"/genfstab -U "${TARGET}" >> "${TARGET}"/etc/fstab

#
# 3. Copy all files
#

# Get the full path of the files directory.
files_directory="$(realpath -e "${FILES_DIRECTORY}")"
files="$(find "${files_directory}" -type f)"
for f in ${files}; do
    # Get the path on the target directory for the file.
    # Add TARGET, subtract files_directory
    file_target_path=""${TARGET}"/"${f#"${files_directory}"}""

    # Instead of mkdir and cp use rsync to preserve users and
    # permissions.
    mkdir -p "$(dirname "${file_target_path}")"
    cp -aR "${f}" "${file_target_path}"
done

#
# 4. Chroot
#

LANG=C.UTF-8 chroot "${TARGET}" /bin/bash

#
# 5. Update APT repositories
#

# APT sources see /etc/apt/sources.list
apt-get update

#
# 6. Timezone
#

# Timezone see /etc/timezone
# see https://wiki.debian.org/TimeZoneChanges
cp /usr/share/zoneinfo/$(cat /etc/timezone) /etc/localtime

#
# 7. Locales, language, keymap
#

if [ -f '/etc/locale.gen' ]; then
    locale-gen
fi
# Language see /etc/locale.conf
# Keymap see /etc/default/keyboard

#
# 8. Install the kernel. FIXME: set a generic version.
#

apt-get install linux-image-4.4.0-34-generic linux-image-extra-4.4.0-34-generic

#
# 9. Install the bootloader
#

if [ "${BOOTLOADER}" = 'GRUB' ]; then
    apt-get install grub os-prober
    grub-install --target=i386-pc "${GRUB_INSTALL_DEVICE}"
    grub-mkconfig -o /boot/grub/grub.cfg
elif [ "${BOOTLOADER}" = 'EXTLINUX' ]; then
    apt-get install extlinux gdisk
    # ./syslinux-install_update -iam
else
    :
fi

#
# 10. Root password
#

chpasswd root:"${ROOT_PASSWORD}"
