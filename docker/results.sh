#!/bin/bash

# this will quickly loop through 8 running containers and spit out the TPS entries in sysbench logs

for c in {1..8}; do echo sybench$c; docker exec sysbench$c grep transactions runlog.log; done
