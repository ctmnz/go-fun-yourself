Video: https://www.youtube.com/watch?v=8fi7uSYlOdc


Start the container:
```bash
sudo apt-get install debootstrap bridge-utils
mkdir stable-chroot
sudo debootstrap --arch=amd64 bionic ./ubuntu-rootfs
sudo go run container.go run /bin/bash

```




Networking: https://medium.com/@teddyking/namespaces-in-go-network-fdcf63e76100





