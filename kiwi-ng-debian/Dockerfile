FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    debootstrap \
    debian-archive-keyring \
    gnupg \
    rsync \
    cpio \
    tar \
    qemu-utils \
    parted \
    gdisk \
    dosfstools \
    xfsprogs \
    e2fsprogs \
    kpartx \
    squashfs-tools \
    grub-pc-bin \
    grub-efi-amd64-bin \
    udev \
    ca-certificates \
    curl \
    xz-utils \
    zstd \
    && python3 -m venv /opt/kiwi \
    && /opt/kiwi/bin/pip install --no-cache-dir kiwi \
    && ln -s /opt/kiwi/bin/kiwi-ng /usr/local/bin/kiwi-ng \
    && rm -rf /var/lib/apt/lists/*
