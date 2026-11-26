# 1. Build the Debian-native KIWI builder image

```sh
docker build -t kiwi-debian .
```

# 2. Run the build (clean /work/out first if a partial build exists)

```sh
sudo rm -rf ./bookworm
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-debian kiwi-ng --profile=bookworm --type=oem system build --description=/work/src --target-dir=/work/bookworm

docker run --rm -v "$(pwd)":/work kiwi-debian qemu-img convert -O qcow2 -c -o compression_type=zstd /work/bookworm/debian.x86_64-bookworm-xfs.qcow2 /work/debian-bookworm-xfs.qcow2

sudo rm -rf ./bookworm-cloud
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-debian kiwi-ng --profile=bookworm-cloud --type=oem system build --description=/work/src --target-dir=/work/bookworm-cloud

docker run --rm -v "$(pwd)":/work kiwi-debian qemu-img convert -O qcow2 -c -o compression_type=zstd /work/bookworm/debian.x86_64-bookworm-cloud-xfs.qcow2 /work/debian-bookworm-cloud-xfs.qcow2

sudo rm -rf ./trixie
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-debian kiwi-ng --profile=trixie --type=oem system build --description=/work/src --target-dir=/work/trixie

docker run --rm -v "$(pwd)":/work kiwi-debian qemu-img convert -O qcow2 -c -o compression_type=zstd /work/bookworm/debian.x86_64-trixie-xfs.qcow2 /work/debian-trixie-xfs.qcow2

sudo rm -rf ./trixie-cloud
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-debian kiwi-ng --profile=trixie-cloud --type=oem system build --description=/work/src --target-dir=/work/trixie-cloud

docker run --rm -v "$(pwd)":/work kiwi-debian qemu-img convert -O qcow2 -c -o compression_type=zstd /work/bookworm/debian.x86_64-trixie-cloud-xfs.qcow2 /work/debian-trixie-cloud-xfs.qcow2
```
