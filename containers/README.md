Start the container:
```bash
sudo apt-get install debootstrap bridge-utils
mkdir stable-chroot
sudo debootstrap --arch=amd64 bionic ./ubuntu-rootfs
sudo go run container.go run /bin/bash

```







### Networking

sudo ip link add veth-host type veth peer name veth-container

cat /sys/fs/cgroup/pids/myhomemadecontaners/cgroup.procs 
>> 27844 <-- pick this.. the first one
>> 27849

sudo ip link set veth-container netns 27844
# you should see the veth-container in the container

## in the container

ifconfig veth-container 10.0.0.3 netmask 255.255.255.0

## in the host

sudo ifconfig veth-host 10.0.0.1 netmask 255.255.255.0

### you should ping the container

ping 10.0.0.1
>> PING 10.0.0.1 (10.0.0.1) 56(84) bytes of data.
>> 64 bytes from 10.0.0.1: icmp_seq=1 ttl=64 time=0.096 ms
>> 64 bytes from 10.0.0.1: icmp_seq=2 ttl=64 time=0.034 ms
>> 64 bytes from 10.0.0.1: icmp_seq=3 ttl=64 time=0.028 ms

### share the internet from the host to the container?

### on the host
sudo /sbin/iptables -t nat -A POSTROUTING -o enp4s0 -j MASQUERADE
sudo /sbin/iptables -A FORWARD -i enp4s0 -o veth-host -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo /sbin/iptables -A FORWARD -i veth-host -o enp4s0 -j ACCEPT


### on the container
ip route add default via 10.0.0.1 dev veth-container
echo "nameserver 8.8.8.8" > /etc/resolv.conf

### you should be able to

ping google.com

## or..

apt update
apt install nginx
/etc/init.d/nginx start
echo "Hello from the container!" > /var/www/html/index.html 

## and from the host

curl http://10.0.0.3

### hm... but it is limited though... only 2 connected points.. 

## macvlan (That is actually dope)
#### on the host (27844 is the process of the container)
sudo ip link add link enp4s0 macvlan1 type macvlan 
sudo ip link set macvlan1 netns 27844

## on the client
dhclient macvlan1 -v



### used links



Video: https://www.youtube.com/watch?v=8fi7uSYlOdc

Networking: https://medium.com/@teddyking/namespaces-in-go-network-fdcf63e76100

https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
https://www.revsys.com/writings/quicktips/nat.html
http://man7.org/linux/man-pages/man4/veth.4.html

