# trisquel-installation-script

## Resources

https://www.debian.org/releases/stable/amd64/apds03.html.en

https://howtos.davidsebek.com/debian-f2fs.html

https://askubuntu.com/questions/1013927/begin-running-scripts-local-block-done-stuck-in-initramfs-on-ubuntu-17

https://wiki.archlinux.org/index.php/Syslinux

## Structure

- Configuration files are imported from `./configs` to the chrooted system.

## Steps

### Stage 0 - prepare

NOTE: This stage needs to be done manually from a live ISO or from another system.

1. Partition the devices
2. Setup RAID, LVM, encryption(s) or whatever [optional]
3. Format partitions with filesystems
4. Mount

### Stage 1 - pre-installation

1. Download and install dependencies for the extra scripts
2. Download extra scripts

### Stage 2 - installation

1. Base system installation
2. Copy files
3. Chroot
4. makedev
5. genfstab
6. Timezone
7. Network configuration
8. APT
9. Locales, language, kemap
10. Install the kernel
11. Install the bootloader
12. root password

### Stage 3 - post-installation

Post install commands: extra commands are imported as-is from a shell file.
For example installing programs and adding users.

### Stage 4 - cleanup

1. Sync
2. Unmount

## LICENSE

See the `LICENSE` file.
