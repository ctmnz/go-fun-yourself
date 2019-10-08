#!/bin/bash

docker run --name postgres1 -e POSTGRES_PASSWORD=pass --net=none -d postgres

ovs-docker del-port devnet eth0 postgres1
ovs-docker add-port devnet eth0 postgres1 --ipaddress=10.15.1.2/16 --gateway=10.15.0.1

