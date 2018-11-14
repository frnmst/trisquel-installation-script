## Stage 3

# For example: f2fs on a root partition
apt-get install f2fs-tools
echo f2fs >> /etc/initramfs-tools/modules
update-initramfs -u

