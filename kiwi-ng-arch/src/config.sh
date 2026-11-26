#!/bin/bash
set -euxo pipefail

# Initialize pacman keyring for first-boot package installs
pacman-key --init
pacman-key --populate archlinux

# Enable core system services
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable qemu-guest-agent
# Enable DNS resolution via systemd-resolved
systemctl enable systemd-resolved
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Enable cloud-init services
systemctl enable cloud-init-main cloud-init-local cloud-init-network cloud-config cloud-final

# Configure mirrorlist for the resulting image
cat << 'EOF' > /etc/pacman.d/mirrorlist
Server = https://fastly.mirror.pkgbuild.com/$repo/os/$arch
Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch
Server = https://ftpmirror.infania.net/mirror/archlinux/$repo/os/$arch
Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://mirror.yandex.ru/archlinux/$repo/os/$arch
EOF

# Set kernel command line for serial + VGA console
mkdir -p /etc/kernel
echo "console=tty0 console=ttyS0,115200n8" > /etc/kernel/cmdline

# Force QEMU/KVM storage and XFS filesystem drivers into the initramfs
sed -i 's/^MODULES=.*/MODULES=(virtio virtio_blk virtio_pci virtio_scsi xfs)/' /etc/mkinitcpio.conf
sed -i 's/^HOOKS=.*/HOOKS=(base systemd modconf block filesystems fsck)/' /etc/mkinitcpio.conf

# Regenerate initramfs (since initrd_system="none" is set in config.xml)
mkinitcpio -P

# Clean instance-specific state so cloud-init initializes fresh on first boot
truncate -s 0 /etc/machine-id
rm -f /var/lib/dbus/machine-id
rm -f /etc/ssh/ssh_host_*
cloud-init clean --logs
