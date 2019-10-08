#!/bin/bash

docker run --cap-add=IPC_LOCK --name vault1 --net=none -d vault
ovs-docker del-port devnet eth0 vault1
ovs-docker add-port devnet eth0 vault1 --ipaddress=10.15.0.41/16 --gateway=10.15.0.1

