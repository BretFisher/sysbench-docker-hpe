Sysbench and Docker Setups to Benchmark Physical, Virtual, and Container-based MySQL
==============================

This repository containers scripts, Dockerfiles, and configs that were used for the Hewlett Packard Enterprise (HPE) and Docker Inc. reference architecture paper "[HPE and Docker Reference Configuration for infrastructure optimization using Docker containers on HPE infrastructure](http://d.pr/f/Zjv65z/1BuMbZ8p)" from early 2017.

You can use the files in each Scenario below to re-create our benchmarks of MySQL being used by Sysbench to get a TPS (Transactions Per Second) out of each Scenario.

The main goal of these reference files is to help you benchmark MySQL and other workloads in your environment as you move from virtual machines to containers-in-vm's and eventually containers-on-bare-metal, and ensure you're seeing the performance improvements you'd expect.

Docker Hub repo is [bretfisher/sysbench-docker-hpe](https://hub.docker.com/r/bretfisher/sysbench-docker-hpe/)

## Versions Tested With

  - RHEL 7.2
  - Docker 1.12
  - MySQL 5.7
  - Sysbench master branch 1/2017

## Scenario 1: Installing MySQL on multiple RHEL 7.2 Virtual Machines

  - Use `/rhel/sysbench_install.sh` to do a scripted install of MySQL and Sysbench on RHEL
  - Use `/rhel/sysbench.sh` to run the sysbench workload 5 times on a instance
  - Use `/rhel/test8.sh` as an example of how you could use tmux to run sysbench workloads across 8 VM's at once

## Scenario 2: Using multiple official MySQL Docker images on a single virtual machine

  - Use `/docker/Dockefile` and `/docker/build.sh` to build a image with MySQL, Sysbench, and scripts installed
  - Or download my image with default values by `docker pull bretfisher/sysbench-docker-hpe` then `docker tag bretfisher/sysbench-docker-hpe sysbench` to give it a friendly name to work with in rest of these scripts
  - Use `/docker/run8.sh` to start 8 containers and build test db's in each one
  - Use `/docker/test8.sh` to start sysbench workloads across 8 containers (detached)
  - Use `/docker/results.sh` to grep transaction results from 8 containers
  - Use `/docker/tmuxtest8.sh` as an examples of how you could use tmux to run sysbench workloads across 8 containers at once

## Scenario 3: Using multiple official MySQL Docker images on a single bare metal host

  - Use the same process as in Scenario 2

## Saving Time
  - You can save time by pulling my `bretfisher/sysbench-docker-hpe` image rather then building your own (if my defaults work for you)
  - As you're doing this you'll start to notice significant time used to run `run8.sh` as the sysbench will be creating sample data for each container. If you're not benchmarking the actual sample data creation (I don't) then you can save time by creating a single container with the sample data, then using `docker commit` to save it (and db's) to a new image, and then run your `test8.sh` from there. Doing this way requires editing the scripts a bit and also means you'll need to store db's *in* your containers, which may not work if you're wanting to test storage that's using Docker Volumes or Bind Mounts.

# Getting help

Add issues to this repo if you have questions or bugs.

# License

MIT License

Copyright (c) 2017 Bret Fisher bret@bretfisher.com
