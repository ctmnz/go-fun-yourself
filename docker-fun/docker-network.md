# Create docker network infrastructure using ovs-docker

## OVS setup

**install openvswitch**
```
apt install openvswitch-switch
```

**create a bridge 'mydocker-br' and the network (10.15.0.0/16) for our docker containers**
```
ovs-vsctl add-br mydocker-br
ifconfing mydocker-br 10.15.0.1 netmask 255.255.0.0 up
```

**create few docker containers (and start /bin/bash just to keep them alive)**
```
docker run -dti --name=amzlinux1 --net=none amazonlinux /bin/bash
docker run -dti --name=amzlinux2 --net=none amazonlinux /bin/bash
docker run -dti --name=amzlinux3 --net=none amazonlinux /bin/bash

docker run -dti --name=ubuntu1 --net=none ubuntu /bin/bash
docker run -dti --name=ubuntu2 --net=none ubuntu /bin/bash

docker run -dti --name=centos1 --net=none centos /bin/bash
docker run -dti --name=centos2 --net=none centos /bin/bash

```

**assign IP addresses to our containers created with the commands above**
```
ovs-docker add-port mydocker-br eth0 amzlinux1 --ipaddress=10.15.0.2/16 --gateway=10.15.0.1
ovs-docker add-port mydocker-br eth0 amzlinux2 --ipaddress=10.15.0.3/16 --gateway=10.15.0.1
ovs-docker add-port mydocker-br eth0 amzlinux3 --ipaddress=10.15.0.4/16 --gateway=10.15.0.1

ovs-docker add-port mydocker-br eth0 ubuntu1 --ipaddress=10.15.0.5/16 --gateway=10.15.0.1
ovs-docker add-port mydocker-br eth0 ubuntu2 --ipaddress=10.15.0.6/16 --gateway=10.15.0.1

ovs-docker add-port mydocker-br eth0 centos1 --ipaddress=10.15.0.7/16 --gateway=10.15.0.1
ovs-docker add-port mydocker-br eth0 centos2 --ipaddress=10.15.0.6/16 --gateway=10.15.0.1
```

**Check the connectivity from the host to the containers**
```
ping 10.15.0.2

ping 10.15.0.3

ping 10.15.0.4

ping 10.15.0.5

ping 10.15.0.6

ping 10.15.0.7

ping 10.15.0.8
```

