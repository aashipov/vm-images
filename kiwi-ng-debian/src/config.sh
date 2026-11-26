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
cat << 'EOF' > /etc/apt/sources.list
deb https://deb.debian.org/debian bookworm main
deb https://deb.debian.org/debian bookworm-updates main
deb https://security.debian.org/debian-security bookworm-security main
EOF
        ;;
    trixie*)
        systemctl enable cloud-init-main cloud-init-local cloud-init-network cloud-config cloud-final
cat << 'EOF' > /etc/apt/sources.list.d/debian.sources
Types: deb
URIs: https://deb.debian.org/debian
Suites: trixie trixie-updates
Components: main
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: https://security.debian.org/debian-security
Suites: trixie-security
Components: main
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
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
