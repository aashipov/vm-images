# 1. Build docker image

```sh
docker build -t kiwi-redos8 .
```

# 2. Run the build

```sh
sudo rm -rf ./redos8
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi kiwi-redos8 kiwi-ng --type=oem system build --description=/work/src --target-dir=/work/redos8
```

# 3. Compress the resulting qcow2 image with zstd

```sh
docker run --rm -v "$(pwd)":/work kiwi-redos8 qemu-img convert -O qcow2 -c -o compression_type=zstd /work/redos8/redos8.x86_64-xfs.qcow2 /work/redos8-xfs.qcow2
```
