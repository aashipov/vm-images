# 1. Build docker image

```sh
docker build -t kiwi-alma9 .
```

# 2. Clean previous output and run KIWI build

```sh
sudo rm -rf ./alma9
docker run --rm --privileged \
-v /dev:/dev \
-v "$(pwd)":/work \
-v "$(pwd)/kiwi-cache":/var/cache/kiwi \
kiwi-alma9 kiwi-ng --type=oem system build --description=/work/src --target-dir=/work/alma9
```

# 3. Compress the resulting qcow2 image with zstd

```sh
docker run --rm -v "$(pwd)":/work kiwi-alma9 \
qemu-img convert -O qcow2 -c -o compression_type=zstd \
/work/alma9/alma9.x86_64-xfs.qcow2 /work/alma9-xfs.qcow2
```
