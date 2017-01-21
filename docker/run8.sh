#! /bin/bash

# this will stop, remove, then start 8 containers.

# use '-v /local/path:/var/lib/mysql' to store db's on host

# Examples of how to control resources
# use '--cpuset-cpus 1-4' to limit container to the first 4 cpu's
# use '--memory 31G' for example to limit container to 31GB

# NOTE: we use --storage-opt size=XXG to ensure the container doesn't fill up during db create

for i in {1..8}
do
  docker stop -t 30 sysbench$i
  docker rm sysbench$i
  docker run -v /var/local/docker_mounts/sysbench$i:/var/lib/mysql -e SYSBENCH_TABLE_SIZE=10000000 --storage-opt size=28G -d --name sysbench$i sysbench
done
