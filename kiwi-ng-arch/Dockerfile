FROM archlinux:base

RUN pacman -Syu --noconfirm --needed \
    python \
    python-pip \
    arch-install-scripts \
    archlinux-keyring \
    gnupg \
    rsync \
    cpio \
    tar \
    qemu-img \
    parted \
    gptfdisk \
    dosfstools \
    xfsprogs \
    e2fsprogs \
    multipath-tools \
    squashfs-tools \
    grub \
    efibootmgr \
    systemd \
    ca-certificates \
    curl \
    xz \
    zstd \
    && python -m venv /opt/kiwi \
    && /opt/kiwi/bin/pip install --no-cache-dir kiwi \
    && ln -s /opt/kiwi/bin/kiwi-ng /usr/local/bin/kiwi-ng \
    && pacman -Scc --noconfirm
