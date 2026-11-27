#!/bin/sh
set -eux

# Enable core system services
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable qemu-guest-agent

# Enable cloud-init services
systemctl enable cloud-init-local cloud-init cloud-config cloud-final

# Force QEMU/KVM storage and XFS drivers into initramfs
cat << 'EOF' > /etc/dracut.conf.d/99-kvm.conf
add_drivers+=" virtio virtio_blk virtio_pci virtio_scsi virtio_net xfs "
EOF

# Set cloud-init datasources
printf 'datasource_list: [ NoCloud, ConfigDrive, None ]\n' > /etc/cloud/cloud.cfg.d/99-datasource.cfg

# Disable SELinux in configuration
if [ -f /etc/selinux/config ]; then
    sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
fi

# Prevent first-boot relabeling
rm -f /.autorelabel

# Clean instance-specific state so cloud-init initializes fresh on first boot
truncate -s 0 /etc/machine-id
rm -f /var/lib/dbus/machine-id
rm -f /etc/ssh/ssh_host_*
cloud-init clean --logs
dnf clean all
