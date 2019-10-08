#!/bin/bash


docker rm -f $(docker ps -qa)

## DB server
docker run -dti --name=devdb --net=none -e MYSQL_ROOT_PASSWORD=pass mysql:5.7

## haproxy
#docker run -dti --name=ha1 --net=none haproxy
#docker run -dti --name=ha2 --net=none haproxy

## nginx instances
docker run -dti --name=devapp1 --net=none nginx
docker run -dti --name=devapp2 --net=none nginx
docker run -dti --name=devapp3 --net=none nginx

docker run -dti --name=devnsql --net=none -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=pass mongo
docker run -dti --name=devetcd --net=none elcolio/etcd

docker run -dti --name=devqueue --net=none rabbitmq

docker run -dti --name=phpmyadmin -e PMA_HOST=10.15.0.2 --net=none phpmyadmin/phpmyadmin

docker run -dti --name=splunk --net=none -e "SPLUNK_START_ARGS=--accept-license" -e "SPLUNK_PASSWORD=pass123!" splunk/splunk:latest

docker run -dti --name=redis --net=none redis

docker run -dti --name=jenkins --net=none jenkins

