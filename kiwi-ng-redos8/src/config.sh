#!/bin/sh
set -eux

# Enable core system services
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable qemu-guest-agent

# Enable cloud-init services
systemctl enable cloud-init-local cloud-init cloud-config cloud-final

# Configure permanent DNF repositories for the resulting image
cat << 'EOF' > /etc/yum.repos.d/redos.repo
[redos-os]
name=RED OS 8.0 - Base
baseurl=https://repo1.red-soft.ru/redos/8.0/$basearch/os
        https://repo2.red-soft.ru/redos/8.0/$basearch/os
        https://repo2.red-soft.ru/redos/8.0/$basearch/os
enabled=1
gpgcheck=0

[redos-updates]
name=RED OS 8.0 - Updates
baseurl=https://repo1.red-soft.ru/redos/8.0/$basearch/updates
        https://repo2.red-soft.ru/redos/8.0/$basearch/updates
        https://repo3.red-soft.ru/redos/8.0/$basearch/updates
enabled=1
gpgcheck=0
EOF

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
cloud-init clean --logs || true
dnf clean all
