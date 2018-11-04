# Resources

https://www.debian.org/releases/stable/amd64/apds03.html.en

# Structure

- Configuration files are imported from `./configs` to the chrooted system.

# Steps

## Stage 0

1. Partition
2. Setup RAID, LVM or whatever (optional)
3. Format
4. Mount

## Stage 1

1. Download and install dependencies

    apt-get install git m4 make

2. Download extra scripts

    git clone https://git.archlinux.org/arch-install-scripts.git
    
    get the syslinux-install_update script. Custom patches are needed...

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
   
5. Timezone

    dpkg-reconfigure tzdata
    
6. Network configuration

7. APT

    Modify /etc/apt/sources.list

8. Locales, language, kemap

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

10. Install the bootloader: extlinux

     apt-get install extlinux gdisk
     ./syslinux-install_update -iam   # A modified version is needed.

11. root password

    passwd 
    
## Stage 3

Post install commands: extra commands are imported as-is from a shell file. For example: installing programs, adding users,
etc...

For example: f2fs on a root partition

    apt-get install f2fs-tools
    echo f2fs >> /etc/initramfs-tools/modules
    update-initramfs -u
