Instruction to install Archlinux with BTRFS filesystem.

Please also use the Archlinux Wiki: https://wiki.archlinux.de/title/Anleitung_für_Einsteiger

### Install the base system

- boot from ISO image
- change default language in terminal
	```
	$ loadkeys de-latin1-nodeadkeys
	```
- Check if you have UEFI mode enabled
	```
	$ ls /sys/firmware/efi/efivars
	```
- list block devices
	```
	$ lsblk
	```
- select the proper block device and run fdisk (e. g. /dev/sda)
	```
	$ fdisk /dev/sda
	```
	- Boot partition
		- n (new partition)
		- Enter (partition ID 1)
		- Enter (default first sector)
		- +512M (last sector and size for this partition)
	- Change partition type for BOOT
		- t
		- 1
	- BTRFS partition
		- n (new partition)
		- Enter (partition ID 2)
		- Enter (default first sector)
		- +224G (last sector and size for this partition)
	- SWAP partition
		- n (new partition)
		- Enter (partition ID 3)
		- Enter (default last free sector)
	- Change partition type for SWAP
		- t
		- 19
	- Print the new partition layout
		- p
	- Write the new partition layout
		- w
- Create the file systems on the new partitions
	```
	mkfs.fat -F32 -n BOOT /dev/sda1
	mkfs.btrfs -L ROOT /dev/sda2 #Skip this step if encrypted partion will be used
	mkswap -L SWAP /dev/sda3

	#In case you want to encrypt the BTRFS partion, follow these steps:
	cryptsetup luksFormat /dev/sda2
	cryptsetup luksOpen /dev/sda2 cryptroot
	mkfs.btrfs -L ROOT /dev/mapper/cryptroot
	```
- Mount the BTRFS partition
	```
	mount /dev/sda2 /mnt

	#In case of a encrypted partition use this command:
	mount /dev/mapper/cryptrool /mnt
	```
- Create the Btrfs subvolumes
	```
	btrfs sub create /mnt/@
	btrfs sub create /mnt/@home
	btrfs sub create /mnt/@pkg
	btrfs sub create /mnt/@snapshots
	```
- Mount the volumes
	```
	ls /mnt
	umount /mnt
	mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@ /dev/sda2 /mnt
	mkdir -p /mnt/boot
	mkdir -p /mnt/home
	mkdir -p /mnt/var/cache/pacman/pkg
	mkdir -p /mnt/.snapshots
	mkdir -p /mnt/btrfs
	mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@home /dev/sda2 /mnt/home
	mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@pkg /dev/sda2 /mnt/var/cache/pacman/pkg
	mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@snapshots /dev/sda2 /mnt/.snapshots
	mount -o noatime,ssd,space_cache=v2,compress=lzo,subvolid=5 /dev/sda2 /mnt/btrfs
	mount /dev/sda1 /mnt/boot/
	swapon /dev/sda3
	free -h
	df -Th
	```
- Install the base system
	```
	pacstrap /mnt base base-devel btrfs-progs bash-completion linux linux-firmware dhcpcd nano
	```
- Create fstab
	```
	genfstab -Lp /mnt >> /mnt/etc/fstab
	```
- chroot to system /mnt
	```
	arch-chroot /mnt
	```
- Configure the base system, install boot loader, additional tools and create users
	```
	pacman -S grub
	pacman -S dosfstools efibootmgr mtools
	mkdir -p /boot/efi
	mount /dev/sda1 /boot/efi
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
	mkdir -p /boot/grub
	grub-mkconfig -o /boot/grub/grub.cfg
	
	echo arch-demo-1 > /etc/hostname
	echo LANG=de_DE.UTF-8 > /etc/locale.conf
	echo LANGUAGE=de_DE >> /etc/locale.conf
	nano /etc/locale.gen
        Suchen und das # am Anfang folgender Zeilen entfernen:
        #de_DE.UTF-8 UTF-8
        #de_DE ISO-8859-1
        #de_DE@euro ISO-8859-15
	locale-gen
	echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf
	ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
	nano /etc/pacman.conf
	    Multilib aktivieren
	pacman -Syu
	passwd
	useradd -m -g users -G wheel,audio,video -s /bin/bash michael
	passwd michael

	#In case you use an encrypted partition:
	nano /etc/mkinitcpio.conf
		add the following:
		MODULES=(btrfs)
		# before the filesystems hook
		HOOKS=(...block encrypt filesystems...)
	mkinitcpio -p linux

	blkid
	#Note the UUID of the encrypted partition

	nano /etc/default/grub
		#edit the line starting with "GRUB_CMDLINE_LINUX_DEFAULT="
		GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=<id>:cryptroot root=/dev/mapper/cryptroot"
	grub-mkconfig -o /boot/grub/grub.cfg
	
	exit
	umount /mnt/boot
	reboot
	```
- Continue with the configuration of the base system
	```
	ip link
	dhcpcd ens18 (change to the correct network interface name)
	ping google (check the connection)
	pacman -S acpid dbus avahi cups cronie
	systemctl enable acpid avahi-daemon cronie.service cups.service
	systemctl enable --now systemd-timesyncd.service
	pacman -S xorg-server xorg-xinit
	lspci | grep VGA
	pacman -S less
	pacman -Ss xf86-video | less
	pacman -S <grafiktreiber-name>
	pacman -S ntp
	systemctl enable ntpd
	localectl set-x11-keymap de pc105 deadgraveacute
	pacman -S git
	```

### Software installation

From this point the installation of additional software can be done with the shell scripts in this repo!
