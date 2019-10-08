#!/bin/bash


docker run --log-driver=splunk --log-opt splunk-token=70636752-d301-4199-ad82-a58e05fd5cfc --log-opt splunk-url=http://10.15.10.2:8088 --name dev-wordpress2 --net=none -d wordpress
ovs-docker add-port devnet eth0 dev-wordpress2 --ipaddress=10.15.2.50/16 --gateway=10.15.0.1


# --log-driver=splunk --log-opt splunk-token=70636752-d301-4199-ad82-a58e05fd5cfc --log-opt splunk-url=http://10.15.10.2:8000/

# 70636752-d301-4199-ad82-a58e05fd5cfc

