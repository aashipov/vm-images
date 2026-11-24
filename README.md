# VM images

RedHat, Inc recommend [XFS-backed storage](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/managing_file_systems/overview-of-available-file-systems) (which is faster and can only grow, `ext4` can also shrink).

## Debian 12 (bookworm) 13 (trixie)

[debos](https://github.com/go-debos/debos) appears less convoluted than [Debian Cloud images](https://salsa.debian.org/cloud-team/debian-cloud-images)

```sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install golang git libglib2.0-dev libostree-dev qemu-system-x86 qemu-user-static debootstrap systemd-container zstd parted xfsprogs
go install -v github.com/go-debos/debos/cmd/debos@latest
```

```sh
debos --disable-fakemachine debian-bookworm-xfs.yaml
debos --disable-fakemachine -t kernel:-cloud debian-bookworm-xfs.yaml
debos --disable-fakemachine debian-trixie-xfs.yaml
debos --disable-fakemachine -t kernel:-cloud debian-trixie-xfs.yaml
```
