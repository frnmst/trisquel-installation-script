# Resources

https://www.debian.org/releases/stable/amd64/apds03.html.en

https://howtos.davidsebek.com/debian-f2fs.html

https://askubuntu.com/questions/1013927/begin-running-scripts-local-block-done-stuck-in-initramfs-on-ubuntu-17

https://wiki.archlinux.org/index.php/Syslinux

# Structure

- Configuration files are imported from `./configs` to the chrooted system.

# Steps

## Stage 0

NOTE: This stage needs to be done manually from a live ISO or from another system.

1. Partition the devices
2. Setup RAID, LVM, encryption(s) or whatever [optional]
3. Format partitions with filesystems
4. Mount

## Stage 1

1. Download and install dependencies

    apt-get install git m4 make

2. Download extra scripts

    git clone https://git.archlinux.org/arch-install-scripts.git
    
    get the syslinux-install_update script. FIXME: Custom patches are needed...

## Stage 2

1. Base system installation

    debootstrap --exclude=ca-certificates --arch amd64 flidas /target https://mirror.fsf.org/trisquel/

2. Chroot

    LANG=C.UTF-8 chroot /target /bin/bash
    
3. makedev

    apt-get install makedev
    mount none /proc -t proc
    cd /dev
    
4. genfstab

   cd /
   ./genfstab -U / >> /etc/fstab
   
5. Timezone FIXME

    dpkg-reconfigure tzdata
    
6. Network configuration

7. APT FIXME

    Add missing entries in `/etc/apt/sources.list`

8. Locales, language, kemap FIXME

    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    
    locale-gen
    
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf
    
    /etc/default/keyboard: 
```
    # KEYBOARD CONFIGURATION FILE
    # Consult the keyboard(5) manual page.

    XKBMODEL="pc105"
    XKBLAYOUT="it"
    XKBVARIANT=""
    XKBOPTIONS=""

    BACKSPACE="guess"
```

9. Install the kernel
 
    apt-get install linux-image-4.4.0-34-generic linux-image-extra-4.4.0-34-generic

10. Install the bootloader

     apt-get install extlinux gdisk
     ./syslinux-install_update -iam

11. root password

    passwd 
    
## Stage 3

Post install commands: extra commands are imported as-is from a shell file. For example: installing programs, adding users,
etc...

For example: f2fs on a root partition

    apt-get install f2fs-tools
    echo f2fs >> /etc/initramfs-tools/modules
    update-initramfs -u
