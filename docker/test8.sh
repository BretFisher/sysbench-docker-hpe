#!/bin/bash

for c in {1..8}

do 
  docker exec -d sysbench$c /bin/bash -c "(for i in {1..4}; do /opt/sysbench_run.sh; done) > runlog.log"
done
