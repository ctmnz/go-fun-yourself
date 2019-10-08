#!/bin/bash


docker run --name sonarqube1 --net=none -d sonarqube
ovs-docker del-port devnet eth0 sonarqube1
ovs-docker add-port devnet eth0 sonarqube1 --ipaddress=10.15.0.30/16 --gateway=10.15.0.1

