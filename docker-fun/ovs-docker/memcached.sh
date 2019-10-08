#!/bin/bash

docker run --name memcached1 --net=none -d memcached
ovs-docker del-port devnet eth0 memcached1
ovs-docker add-port devnet eth0 memcached1 --ipaddress=10.15.0.40/16 --gateway=10.15.0.1

