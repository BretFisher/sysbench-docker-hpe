#!/usr/bin/tmux source-file

# TO USE:
# 1. start containers with run8.sh
# 2. start tmux and detach it (so it will keep running in background) with ctrl-b, ctrl-d
# 3. run this script
# 4. attach to tmux with `tmux at`, and you might need to switch between sessions with ctrl-b, s


# this is an example of how you might run 8 tests in existing docker containers (started by run8.sh)
# and watch them in real-time with tmux windows for each `docker exec` command.
# note we only do 4 passes of sysbench testing in this example, and there's likely a shorter way to 
# loop through it inside each running container.

new-session -d
split-window -d -t 0 -v
select-layout tiled
split-window -d -t 0 -v
select-layout tiled
split-window -d -t 0 -v
select-layout tiled
split-window -d -t 0 -v
select-layout tiled
split-window -d -t 0 -v
select-layout tiled
split-window -d -t 0 -v
select-layout tiled
split-window -d -t 0 -v
select-layout tiled

send-keys -t 0 'docker exec -it sysbench1 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 1 'docker exec -it sysbench2 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 2 'docker exec -it sysbench3 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 3 'docker exec -it sysbench4 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 4 'docker exec -it sysbench5 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 5 'docker exec -it sysbench6 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 6 'docker exec -it sysbench7 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter
send-keys -t 7 'docker exec -it sysbench8 /bin/sh -c "echo run one; /opt/sysbench_run.sh; echo run two; /opt/sysbench_run.sh; echo run three; /opt/sysbench_run.sh; echo run four; /opt/sysbench_run.sh"' enter


