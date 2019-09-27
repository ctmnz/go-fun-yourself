Video: https://www.youtube.com/watch?v=8fi7uSYlOdc


Additional:
- Create chroot evironment for the demo (https://wiki.debian.org/Debootstrap)
```bash
sudo apt-get install debootstrap
mkdir stable-chroot
sudo debootstrap --arch=amd64 bionic ./ubuntu-rootfs
sudo go run container.go run /bin/bash

```




