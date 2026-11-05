# Arch Linux installation — UEFI, Btrfs, optional LUKS (draft)

> **Review required.** This is a proposed replacement for the older `Archlinux Setup.md`, not a tested installer. It is designed for a **dedicated, disposable x86_64 UEFI disk** with GRUB and an unencrypted EFI system partition (ESP) mounted at `/boot`. Do not apply to a dual-boot machine or a disk with data. **Partitioning, formatting and LUKS initialization destroy data.** Validate the layout in a UEFI virtual machine first.

Upstream sources: [Installation guide](https://wiki.archlinux.org/title/Installation_guide), [Btrfs](https://wiki.archlinux.org/title/Btrfs), [dm-crypt: encrypting an entire system](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system), [GRUB](https://wiki.archlinux.org/title/GRUB), [mkinitcpio](https://wiki.archlinux.org/title/Mkinitcpio).

## Design decisions

- UEFI/GPT only; a **new** FAT32 ESP at `/boot` (suggest 1 GiB) and one Btrfs root partition; an optional separate swap partition is deliberately **not** created by this guide.
- Optional LUKS2 protects the Btrfs root. The ESP is **not encrypted**. This does not protect the kernel/initramfs from offline tampering; consider Secure Boot/UKIs separately.
- Btrfs subvolumes: `@`, `@home`, `@pkg`, `@snapshots`. Compression `zstd` and `noatime`; no unconditional SSD-only mount option.
- GRUB + mkinitcpio **systemd** initramfs. For encrypted root use `sd-encrypt` with `rd.luks.name`, **not** the old `encrypt`/`cryptdevice` combination.
- Networking, swap/hibernation, microcode, GPU drivers and desktop installation require machine-specific choices.

## 1. Confirm the target and firmware

Boot the current Arch installation ISO in UEFI mode and connect to the network. Use `iwctl` if Wi-Fi requires configuration. All commands in the live ISO run as root.

```bash
loadkeys de-latin1-nodeadkeys
test -d /sys/firmware/efi/efivars && echo 'UEFI boot confirmed'
timedatectl
lsblk -o NAME,SIZE,MODEL,TYPE,FSTYPE,MOUNTPOINTS
```

**Stop if UEFI is not confirmed.** Identify the correct disk using its size/model and stable `/dev/disk/by-id/` path. This guide intentionally does not include an unattended partitioning command. Create GPT partitions using `cfdisk` or `fdisk` and inspect the result:

1. ESP: 1 GiB, type **EFI System**.
2. Root: remaining intended space, type **Linux filesystem**.

Assign the resulting partition paths in the shell, **replacing placeholders**:

```bash
ESP=/dev/disk/by-id/REPLACE_WITH_ESP_PARTITION
ROOT_PART=/dev/disk/by-id/REPLACE_WITH_ROOT_PARTITION
lsblk -f "$ESP" "$ROOT_PART"
```

These variables are only available in the current shell. **Do not proceed unless both paths match the intended new partitions.** Never format an existing shared ESP.

## 2. Format and unlock root

Choose exactly **one** root variant.

### Variant A — no encryption

```bash
mkfs.btrfs -L ARCHROOT "$ROOT_PART"
ROOT_DEVICE="$ROOT_PART"
```

### Variant B — LUKS2-encrypted root

```bash
cryptsetup luksFormat --type luks2 "$ROOT_PART"
cryptsetup open "$ROOT_PART" cryptroot
mkfs.btrfs -L ARCHROOT /dev/mapper/cryptroot
ROOT_DEVICE=/dev/mapper/cryptroot
```

Format the **newly created** ESP only:

```bash
mkfs.fat -F 32 "$ESP"
```

## 3. Create and mount Btrfs subvolumes

```bash
mount "$ROOT_DEVICE" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@pkg
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount -o noatime,compress=zstd,subvol=@ "$ROOT_DEVICE" /mnt
mkdir -p /mnt/{boot,home,.snapshots,var/cache/pacman/pkg}
mount -o noatime,compress=zstd,subvol=@home "$ROOT_DEVICE" /mnt/home
mount -o noatime,compress=zstd,subvol=@pkg "$ROOT_DEVICE" /mnt/var/cache/pacman/pkg
mount -o noatime,compress=zstd,subvol=@snapshots "$ROOT_DEVICE" /mnt/.snapshots
mount "$ESP" /mnt/boot
findmnt -R /mnt
```

Do not also mount the raw encrypted partition; all Btrfs mounts must use the same unlocked `ROOT_DEVICE`.

## 4. Install the base system

```bash
pacstrap -K /mnt base linux linux-firmware btrfs-progs cryptsetup grub efibootmgr networkmanager sudo nano
genfstab -U /mnt > /mnt/etc/fstab
cat /mnt/etc/fstab
arch-chroot /mnt
```

Inspect `fstab` for exactly the expected root, home, package-cache, snapshots and ESP mounts. Add the appropriate Intel or AMD microcode package for the target CPU, if applicable.

## 5. Configure the installed system (inside arch-chroot)

```bash
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
sed -i 's/^#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
printf 'LANG=de_DE.UTF-8\n' > /etc/locale.conf
printf 'KEYMAP=de-latin1-nodeadkeys\n' > /etc/vconsole.conf
printf 'arch-workstation\n' > /etc/hostname
passwd
systemctl enable NetworkManager
```

Create a **chosen** non-root user, set a password, add to `wheel`, and configure sudo access with `visudo`. Do not copy a hard-coded personal username. Set hostname and network policy appropriate to your environment.

### Configure initramfs

Edit `/etc/mkinitcpio.conf`. Keep relevant hardware/autodetect/microcode hooks. For this guide's **systemd-based** initramfs, the hooks must include:

- Unencrypted: `systemd`, `keyboard`, `sd-vconsole`, `block`, `filesystems` (with other appropriate standard hooks).
- Encrypted: the above **plus `sd-encrypt` after `block` and before `filesystems`**.

Example for encrypted root:

```text
HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)
```

Check that each hook exists in the installed version and that the chosen console keymap is available at the LUKS prompt. Regenerate images **after** saving the configuration:

```bash
mkinitcpio -P
```

### Configure GRUB

For **encrypted** root only, retrieve the LUKS UUID from the original root partition (`blkid` on the live ISO before chroot, or `blkid` on the corresponding device inside chroot). In `/etc/default/grub`, add these parameters to `GRUB_CMDLINE_LINUX`, substituting the actual UUID:

```text
rd.luks.name=YOUR_LUKS_PARTITION_UUID=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@
```

For **unencrypted** root, do not add LUKS parameters; GRUB and the generated fstab must point to the Btrfs root with `subvol=@`. Do not enable `GRUB_ENABLE_CRYPTODISK` for this design: `/boot` is an unencrypted ESP.

```bash
findmnt /boot
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

## 6. Pre-reboot checks

- `/boot` is mounted to the new ESP; `/boot/grub/grub.cfg`, kernel and initramfs exist there.
- `fstab` has correct UUIDs and Btrfs subvolume options.
- For LUKS, `blkid` UUID, `rd.luks.name`, mapping name and `sd-encrypt` agree.
- `mkinitcpio -P` and `grub-install` completed without errors.
- A root password, normal user and working network service are configured.
- Recovery USB and a backup exist. **A successful boot has not been validated by this document.**

Exit the chroot, unmount recursively, close the LUKS mapping only after unmounting if applicable, and reboot. Confirm networking and user access before running any post-install scripts.

## Explicitly out of scope

BIOS/legacy boot, dual boot, existing ESP reuse, encrypted swap, hibernation, TPM unlocking, Secure Boot, snapshots/rollback integration, automatic partitioning, and vendor-specific GPU/desktop setup. These require separate reviewed instructions.
