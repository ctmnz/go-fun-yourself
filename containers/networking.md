Create network namespaces:

```
ip netns add GREEN
ip netns add RED
```

Create virtual router OVS1:

```
ovs-vsctl add-br OVS1
```

Create the veth pairs 'then cables' that are going to connect the networks and the switch

```
ip link add ETH0-R type veth peer name VETH-R
ip link set ETH0-R netns RED
ovs-vsctl add-port OVS1 VETH-R

ip link add ETH0-G type veth peer name VETH-G
ip link set ETH0-G netns GREEN
ovs-vsctl add-port OVS1 VETH-G

```

Bring the interfaces up and set IP addresses
```
ip link set VETH-R up
ip netns exec red ip link set dev lo up
ip netns exec red ip link set dev ETH0-R up
ip netns exec red ip address add 10.0.0.1/24 dev ETH0-R
ip netns exec red ip a
ip netns exec red ip route

ip link set VETH-G up
ip netns exec green ip link set dev lo up
ip netns exec green ip link set dev ETH0-G up
ip netns exec green ip address add 10.0.0.2/24 dev ETH0-G
ip netns exec red ip a
ip netns exec red ip route

```


Use the network from the host
```
ip link add ETH-HOST type veth peer name VETH-HOST
ovs-vsctl add-port ovs1 VETH-HOST
ip link set dev VETH-HOST up
ip link set dev ETH-HOST up
ip address add 10.0.0.3/24 dev ETH-HOST

```


Join a container in the party
```
sudo go run container.go run /bin/bash

# In the host
CPID=$(cat /sys/fs/cgroup/pids/myhomemadecontaners/cgroup.procs | head -n 1)
ip link add eth-container type veth peer name veth-container
ovs-vsctl add-port ovs1 veth-container
ip link set dev veth-container up
ip link set eth-container netns $CPID

# In the container
ip address add 10.0.0.5/24 dev eth-container
ip link set dev eth-container up

```

Provide internet to the container
```
### on the host
sudo /sbin/iptables -t nat -A POSTROUTING -o enp4s0 -j MASQUERADE
sudo /sbin/iptables -A FORWARD -i enp4s0 -o eth-host -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo /sbin/iptables -A FORWARD -i eth-host -o enp4s0 -j ACCEPT


### on the container (using 10.0.0.3 because the host has this address)
ip route add default via 10.0.0.3 dev eth-container
echo "nameserver 8.8.8.8" > /etc/resolv.conf

```





Links:

https://www.youtube.com/watch?v=_WgUwUf1d34

