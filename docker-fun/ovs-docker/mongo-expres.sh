#!/bin/bash

docker run --log-driver=splunk --log-opt splunk-token=70636752-d301-4199-ad82-a58e05fd5cfc --log-opt splunk-url=http://10.15.10.2:8088 --name mongoexpres --net=none -d -e ME_CONFIG_MONGODB_SERVER=10.15.0.8 -e ME_CONFIG_MONGODB_ADMINUSERNAME=root -e ME_CONFIG_MONGODB_ADMINPASSWORD=pass mongo-express

ovs-docker del-port devnet eth0 mongoexpres
ovs-docker add-port devnet eth0 mongoexpres --ipaddress=10.15.2.51/16 --gateway=10.15.0.1



