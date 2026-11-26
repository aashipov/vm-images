# 1. Build the Debian-native KIWI builder image

```sh
docker build -t kiwi-debian .
```

# 2. Run the build (clean /work/out first if a partial build exists)

```sh
sudo rm -rf ./bookworm
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-debian --profile=bookworm --type=oem system build --description=/work/src --target-dir=/work/bookworm

sudo rm -rf ./trixie
docker run --rm --privileged -v /dev:/dev -v "$(pwd)":/work -v "$(pwd)/kiwi-cache":/var/cache/kiwi  kiwi-debian --profile=trixie --type=oem system build --description=/work/src --target-dir=/work/trixie
```
