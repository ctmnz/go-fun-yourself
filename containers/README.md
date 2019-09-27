Video: https://www.youtube.com/watch?v=8fi7uSYlOdc


Start the container:
```bash
sudo apt-get install debootstrap
mkdir stable-chroot
sudo debootstrap --arch=amd64 bionic ./ubuntu-rootfs
sudo go run container.go run /bin/bash

```




