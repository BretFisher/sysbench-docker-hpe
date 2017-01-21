#!/bin/bash

# this is an example of how you can use a small shell script
# to stop and remove all testing containers. 
# The reason we stop them gracefully before removing is in case
# your storing DB's in a docker volume, the DB's will exit cleanly


for i in {1..8}
do
  docker stop -t 30 sysbench$i
  docker rm sysbench$i
done

