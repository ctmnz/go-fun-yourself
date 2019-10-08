#!/bin/bash

docker run  -v /root/DEV/ovs-docker/jenkins:/var/jenkins_home:z --name jenkins-master --net=none -d jenkins/jenkins

ovs-docker del-port devnet eth0 jenkins-master
ovs-docker add-port devnet eth0 jenkins-master --ipaddress=10.15.0.22/16 --gateway=10.15.0.1

