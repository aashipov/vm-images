FROM fedora:34
# fedora:34 as sgdisk issues workaround

RUN dnf install -y \
    python3 \
    python3-pip \
    dnf \
    rpm \
    gnupg2 \
    rsync \
    cpio \
    tar \
    qemu-img \
    parted \
    gdisk \
    dosfstools \
    xfsprogs \
    e2fsprogs \
    device-mapper-multipath \
    squashfs-tools \
    grub2-pc \
    grub2-pc-modules \
    grub2-efi-x64 \
    grub2-efi-x64-modules \
    grub2-tools \
    shim-x64 \
    efibootmgr \
    systemd \
    ca-certificates \
    curl \
    xz \
    zstd \
    openssl \
    && python3 -m venv /opt/kiwi \
    && /opt/kiwi/bin/pip install --no-cache-dir kiwi \
    && ln -s /opt/kiwi/bin/kiwi-ng /usr/local/bin/kiwi-ng \
    && dnf clean all
