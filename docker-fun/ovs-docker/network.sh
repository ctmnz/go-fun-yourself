### Network

ovs-vsctl del-br devnet
ovs-vsctl add-br devnet
ifconfig devnet 10.15.0.1 netmask 255.255.0.0 up

ovs-docker add-port devnet eth0 devdb --ipaddress=10.15.0.2/16 --gateway=10.15.0.1

#ovs-docker add-port devnet eth0 ha1 --ipaddress=10.15.0.3/16 --gateway=10.15.0.1
#ovs-docker add-port devnet eth0 ha2 --ipaddress=10.15.0.4/16 --gateway=10.15.0.1

ovs-docker add-port devnet eth0 devapp1 --ipaddress=10.15.0.5/16 --gateway=10.15.0.1
ovs-docker add-port devnet eth0 devapp2 --ipaddress=10.15.0.6/16 --gateway=10.15.0.1
ovs-docker add-port devnet eth0 devapp3 --ipaddress=10.15.0.7/16 --gateway=10.15.0.1

ovs-docker add-port devnet eth0 devnsql --ipaddress=10.15.0.8/16 --gateway=10.15.0.1
ovs-docker add-port devnet eth0 devetcd --ipaddress=10.15.0.9/16 --gateway=10.15.0.1

ovs-docker add-port devnet eth0 devqueue --ipaddress=10.15.0.10/16 --gateway=10.15.0.1
ovs-docker add-port devnet eth0 phpmyadmin --ipaddress=10.15.10.1/16 --gateway=10.15.0.1

ovs-docker add-port devnet eth0 splunk --ipaddress=10.15.10.2/16 --gateway=10.15.0.1
ovs-docker add-port devnet eth0 redis --ipaddress=10.15.0.20/16 --gateway=10.15.0.1






sudo /sbin/iptables -t nat -A POSTROUTING -o enp4s0 -j MASQUERADE
sudo /sbin/iptables -I FORWARD -i enp4s0 -o devnet -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo /sbin/iptables -I FORWARD -i devnet -o enp4s0 -j ACCEPT



