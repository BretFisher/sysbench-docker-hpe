#!/bin/sh

# copy this to /root on each vm with sysbench so you can kick it off
# remotely. The reason for 5 runs is:
# runs 1 and 2: warmup cache
# runs 3 and 4: document TPS and average
# runs 5: used to ensure all vm's are done with runs 3 and 4 before 
# any stop working

echo "Starting run 1 of 5 $(date)"
echo "###### FIRST RUN $(date)" > sysbench.log
./sysbench_run.sh >> sysbench.log
echo "Starting run 2 of 5 $(date)"
echo "###### SECOND RUN $(date)" >> sysbench.log
./sysbench_run.sh >> sysbench.log
echo "Starting run 3 of 5 $(date)"
echo "###### THIRD RUN $(date)" >> sysbench.log
./sysbench_run.sh >> sysbench.log
echo "Starting run 4 of 5 $(date)"
echo "###### FOURTH RUN $(date)" >> sysbench.log
echo "Starting run 5 of 5 $(date)"
echo "###### FIFTH RUN $(date)" >> sysbench.log
./sysbench_run.sh >> sysbench.log
