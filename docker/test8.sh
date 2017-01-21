#!/bin/bash

# this will run 5 passes of sysbench on each of 8 containers (they must be started first)

# Note you can use the following ENV variables to control certain things at test runtime
# defaults are in Dockerfile
# just add to docker exec command
# `-e SYSBENCH_NUM_THREADS`    # number of total cpu threads sysbench will use per container
# `-e SYSBENCH_MAX_TIME`       # quit sysbench test after X seconds
# `-e SYSBENCH_MAX_REQUESTS`   # quit sysbench test after X SQL requests

for c in {1..8}

do 
  docker exec -d sysbench$c /bin/bash -c "(for i in {1..5}; do /opt/sysbench_run.sh; done) > runlog.log"
done
