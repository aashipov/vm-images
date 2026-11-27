# 1. Build docker image

```sh
docker build -t kiwi-arch .
```

# 2. Run the build (clean /work/out first if a partial build exists)

```sh
sudo rm -rf ./arch
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-arch kiwi-ng --type=oem system build --description=/work/src --target-dir=/work/arch

docker run --rm -v "$(pwd)":/work kiwi-arch qemu-img convert -O qcow2 -c -o compression_type=zstd /work/arch/archlinux.x86_64-xfs.qcow2 /work/archlinux-xfs.qcow2
```
