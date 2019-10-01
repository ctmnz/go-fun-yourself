
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



