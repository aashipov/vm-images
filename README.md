# VM images

## Debian 12 (bookworm) 13 (trixie)

```sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install golang git libglib2.0-dev libostree-dev qemu-system-x86 qemu-user-static debootstrap systemd-container zstd parted xfsprogs
go install -v github.com/go-debos/debos/cmd/debos@latest
```

```sh
debos --disable-fakemachine debian-bookworm-xfs.yaml
debos --disable-fakemachine -t suite:trixie debian-cloud-xfs.yaml
```
