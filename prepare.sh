#!/bin/bash
docker-compose up -d rabbitmq
sleep 10
docker-compose exec rabbitmq rabbitmqctl add_vhost /sensu
sleep 10
docker-compose exec rabbitmq rabbitmqctl add_user sensu secret
sleep 10
docker-compose exec rabbitmq rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
sleep 10
docker-compose up -d
