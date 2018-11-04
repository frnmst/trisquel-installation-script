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
    
    get the syslinux-install_update script

## Stage 2

1. Base system installation

    debootstrap --exclude=ca-certificates --arch amd64 flidas /target https://mirror.fsf.org/trisquel/
