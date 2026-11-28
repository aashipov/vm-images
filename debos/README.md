# VM images

RedHat, Inc recommend [XFS-backed storage](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/managing_file_systems/overview-of-available-file-systems) (which is faster and can only grow, `ext4` can also shrink).

## Debian 12 (bookworm) 13 (trixie)

[debos](https://github.com/go-debos/debos) appears less convoluted than [Debian Cloud images](https://salsa.debian.org/cloud-team/debian-cloud-images)

Limitations: debian and descendants only, no package cache (online repos or a local HTTP mirror, e.g. from DVD ISO)

```sh
cp .env.template .env
```

Adjust `.env` to your liking

```sh
docker builder prune -fa
docker-compose build
docker compose run --rm builder
```
