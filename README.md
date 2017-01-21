Sysbench and Docker Setups to Benchmark Physical, Virtual, and Container-based MySQL
==============================

This repository containers scripts, Dockerfiles, and configs that were used for the Hewlett Packard Enterprise (HPE) and Docker Inc. reference architecture paper `name pending` from early 2017.

You can use the files in each Scenario below to re-create our benchmarks of MySQL being used by Sysbench to get a TPS (Transactions Per Second) out of each Scenario.

The main goal of these reference files is to help you benchmark MySQL and other workloads in your environment as you move from virtual machines to containers-in-vm's and eventually containers-on-bare-metal, and ensure you're seeing the performance improvements you'd expect.

direct-lvm, device mapper, bind mounts, and volume formatting


## Scenario 1: Installing MySQL on multiple RHEL 7.2 Virtual Machines

## Scenario 2: Using multiple official MySQL Docker images on a single virtual machine

## Scenario 3: Using multiple official MySQL Docker images on a single bare metal host

# Getting help

Add issues to this repo if you have questions or bugs.

# License

MIT License

Copyright (c) 2017 Bret Fisher bret@bretfisher.com