#!/bin/bash
set -euxo pipefail

# Enable core system services
systemctl enable ssh
systemctl enable NetworkManager
systemctl enable qemu-guest-agent

# Enable suite-specific cloud-init services using KIWI's active profile variable
case "${kiwi_profiles}" in
    bookworm*)
        systemctl enable cloud-init-local cloud-init cloud-config cloud-final
        ;;
    trixie*)
        systemctl enable cloud-init-main cloud-init-local cloud-init-network cloud-config cloud-final
        ;;
esac

# Set kernel command line for serial + VGA console (read automatically by KIWI NG 10+)
mkdir -p /etc/kernel
echo "console=tty0 console=ttyS0,115200n8" > /etc/kernel/cmdline

# Clean instance-specific state so cloud-init initializes fresh on first boot
truncate -s 0 /etc/machine-id
rm -f /var/lib/dbus/machine-id
rm -f /etc/ssh/ssh_host_*
cloud-init clean --logs
