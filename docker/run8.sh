#! /bin/bash

# this will stop, remove, then start 8 containers.

# use '-v /local/path:/var/lib/mysql' to store db's on host

# Note you can use the following ENV variables to control certain things at runtime
# defaults are in Dockerfile
# just add to docker run command (before the final sysbench image name)
# (before db's are built)
# `-e SYSBENCH_TABLE_COUNT=3`        # number of db tables to fill with records
# `-e SYSBENCH_TABLE_SIZE=1000000`   # number of records to fill in each table

# Examples of how to control resources
# use '--cpuset-cpus 1-4' to limit container to the first 4 cpu's
# use '--memory 31G' for example to limit container to 31GB

# NOTE: we use --storage-opt size=XXG to ensure the container doesn't fill up during db create on devicemapper storage driver
# if you're using something other then devicemapper you may need to remove storage-opt
# https://docs.docker.com/engine/reference/commandline/run/#set-storage-driver-options-per-container

for i in {1..8}
do
  docker stop -t 30 sysbench$i
  docker rm sysbench$i
  docker run -v /var/local/docker_mounts/sysbench$i:/var/lib/mysql --storage-opt size=28G -d --name sysbench$i sysbench
done
