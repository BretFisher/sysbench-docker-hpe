#!/usr/bin/tmux source-file

# example file for how you might run the test runs across
# 8 machines at once from a tmux session on remote host

new-session -s "test8" -d
split-window -d -t 1 -v
split-window -d -t 1 -h
select-layout tiled
split-window -d -t 1 -v
split-window -d -t 3 -v
select-layout tiled
split-window -d -t 1 -h
split-window -d -t 1 -v
select-layout tiled
split-window -d -t 1 -v
select-layout tiled

send-keys -t 1 'ssh sysbench1 bash ~/sysbench.sh' enter
send-keys -t 2 'ssh sysbench2 bash ~/sysbench.sh' enter
send-keys -t 3 'ssh sysbench3 bash ~/sysbench.sh' enter
send-keys -t 4 'ssh sysbench4 bash ~/sysbench.sh' enter
send-keys -t 5 'ssh sysbench5 bash ~/sysbench.sh' enter
send-keys -t 6 'ssh sysbench6 bash ~/sysbench.sh' enter
send-keys -t 7 'ssh sysbench7 bash ~/sysbench.sh' enter
send-keys -t 8 'ssh sysbench8 bash ~/sysbench.sh' enter

attach
