FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    debos \
    debootstrap \
    dosfstools \
    e2fsprogs \
    kmod \
    libostree-1-1 \
    linux-image-amd64 \
    parted \
    qemu-system-x86 \
    qemu-user-static \
    systemd-container \
    udev \
    xfsprogs \
    qemu-utils \
    zstd \
    && depmod -a "$(ls /lib/modules)" \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /recipes
