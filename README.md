Sysbench and Docker Setups to Benchmark Physical, Virtual, and Container-based MySQL
==============================

This repository containers scripts, Dockerfiles, and configs that were used for the Hewlett Packard Enterprise (HPE) and Docker Inc. reference architecture paper `name pending` from early 2017.

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

  - Use `/docker/Dockefile` to build a image with MySQL, Sysbench, and scripts installed, or download an image with default values by `docker pull bretfisher/sysbench-docker-hpe`
  - Use `/docker/build.sh` as an example build command to make your own image
  - Use `/docker/run8.sh` to start 8 containers and build test db's in each one
  - Use `/docker/test8.sh` to start sysbench workloads across 8 containers (detached)
  - Use `/docker/results.sh` to grep transaction results from 8 containers
  - Use `/docker/tmuxtest8.sh` as an examples of how you could use tmux to run sysbench workloads across 8 containers at once

## Scenario 3: Using multiple official MySQL Docker images on a single bare metal host

  - Use the same process as in Scenario 2

# Getting help

Add issues to this repo if you have questions or bugs.

# License

MIT License

Copyright (c) 2017 Bret Fisher bret@bretfisher.com
