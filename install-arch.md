# Notes to Install Arch Linux

1. Boot into arch off a USB stick

2. Find disk with `fdisk -l`

3. Open disk partitioning with `cfdisk  <disk e.g. /dev/sda>`

4. Make swap space of size 1/2 amount of RAM
    - Set FS type to swap (82)

5. Make root partition, fill up disk
    - Add boot flag

6. Write partition table and quit

7. Format root partition with ext4: `mkfs.ext4 <partition e.g. /dev/sda2>`

8. Mount root partition with `mount <partition> /mnt`

9. Make swap file `mkswap <swap partition e.g. /dev/sda1>` and setup with `swapon <swap partition>`

10. Connect to WiFi if needed with `wifi-menu`

11. Install packages to root mount with `pacstrap /mnt base base-devel`

12. Chroot in with `arch-chroot /mnt`

13. Set root password with `passwd`

14. Uncomment appropriate locale in `/etc/locale.gen` and run `locale-gen`

15. Set timezone with `ln -s /usr/share/zoneinfo/<timezone> /etc/localtime`, may need `-sf`

16. Put host name in `/etc/hostname`

17. Install grub `pacman -S grub-bios`

18. Install grub to disk `grub-install <disk e.g. /dev/sda>`

19. Configure with `mkinitcpio -p linux`

20. Generate grub config with `grub-mkconfig -o /boot/grub/grub.cfg`

21. (recommended) Install NetworkManager while you have a working network connection `pacman -S networkmanager`

22. Exit session and return to installer with `exit`

23. Generate fstab file with `genfstab /mnt >> /mnt/etc/fstab`

24. Unmount root partition `umount /mnt`

25. Boot from disk
