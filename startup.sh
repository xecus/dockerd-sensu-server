#!/bin/bash

service sensu-server start
service sensu-client start
service sensu-api start
service uchiwa start

while [ : ]; do
  sleep 1
done
