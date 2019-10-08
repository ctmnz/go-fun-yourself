#!/bin/bash

docker run --name adminer1 --net=none -d adminer

ovs-docker del-port devnet eth0 adminer1
ovs-docker add-port devnet eth0 adminer1 --ipaddress=10.15.1.3/16 --gateway=10.15.0.1





