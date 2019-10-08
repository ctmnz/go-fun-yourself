#!/bin/bash

docker run --name dev-wordpress --net=none -d wordpress
ovs-docker add-port devnet eth0 dev-wordpress --ipaddress=10.15.2.10/16 --gateway=10.15.0.1
