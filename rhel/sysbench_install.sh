#!/bin/sh
# scenario1/1-sysbench_install.sh

# this script is meant to be run on a VM running RHEL/CentOS
# it installs MySQL and Sysbench
# then creats scripts to prepare and run sysbench tests

## update these to your environment
######################################

SYSBENCH_TABLE_SIZE=100000000       # how many records for sysbench to create in each table
SYSBENCH_TABLE_COUNT=3              # how many tables for sysbench to create in db
SYSBENCH_NUM_THREADS=40             # how many concurrent threads should sysbench run
SYSBENCH_MAX_TIME=1200              # quit the test run if you hit this time limit, in seconds
SYSBENCH_MAX_REQUESTS=1000000       # quit the test run after this many requests to db

MYSQL_DATABASE=sysbench
MYSQL_USER=root
MYSQL_PASSWORD=pass22TT
MYSQL_BUFFERSIZE=2G                 # set to 60-80% of memory on the OS
MYSQL_LOGSIZE=512M                   # anything above 64M didn't seem to make a perf difference 
MYSQL_FLUSHLOG=1
MYSQL_FLUSHMETHOD=O_DIRECT

#####################################

## if running ESXi, uncomment this and update the tools to your specific version
# mkdir /mnt/cdrom
# mount /dev/cdrom /mnt/cdrom
# cp /mnt/cdrom/* /tmp/
# cd /tmp
# rm -rf vmware-tools-distrib
# tar -zxvf /tmp/VMwareTools-10.0.6-3560309.tar.gz # rename to your version
# cd vmware-tools-distrib
# ./vmware-install.pl

# lets use mysql offical repository to install mysql 5.7
rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
yum -y update
yum install -y mysql-community-server
echo "innodb_buffer_pool_size = ${MYSQL_BUFFERSIZE}" >> /etc/my.cnf
echo "innodb_log_file_size = ${MYSQL_LOGSIZE}" >> /etc/my.cnf
echo "innodb_flush_log_at_trx_commit = ${MYSQL_FLUSHLOG}" >> /etc/my.cnf
echo "innodb_flush_method = ${MYSQL_FLUSHMETHOD}" >> /etc/my.cnf
echo "[client]" >> /etc/my.cnf
echo "user=${MYSQL_USER}" >> /etc/my.cnf
echo "password=${MYSQL_PASSWORD}" >> /etc/my.cnf

systemctl start mysqld.service

# install and build sysbench
yum install -y git automake libtool make mysql-devel vim
git clone https://github.com/akopytov/sysbench.git
cd sysbench && ./autogen.sh && ./configure && make
cp sysbench/sysbench /usr/local/bin/

# create sysbench scripts
echo "./sysbench/sysbench --test=sysbench/tests/include/oltp_legacy/oltp.lua --oltp-tables-count=${SYSBENCH_TABLE_COUNT} --oltp-table-size=${SYSBENCH_TABLE_SIZE} --mysql-db=${MYSQL_DATABASE} --mysql-user=${MYSQL_USER} --mysql-password=${MYSQL_PASSWORD} prepare" > ./sysbench_prepare.sh
echo "./sysbench/sysbench --test=sysbench/tests/include/oltp_legacy/oltp.lua --oltp-tables-count=${SYSBENCH_TABLE_COUNT} --oltp-table-size=${SYSBENCH_TABLE_SIZE} --oltp-test-mode=complex --num-threads=${SYSBENCH_NUM_THREADS} --max-time=${SYSBENCH_MAX_TIME} --max-requests=${SYSBENCH_MAX_REQUESTS} --mysql-db=${MYSQL_DATABASE} --mysql-user=${MYSQL_USER} --mysql-password=${MYSQL_PASSWORD} run" > ./sysbench_run.sh
echo "./sysbench/sysbench --test=sysbench/tests/db/oltp.lua --oltp-tables-count=${SYSBENCH_TABLE_COUNT} --mysql-db=${MYSQL_DATABASE} --mysql-user=${MYSQL_USER} --mysql-password=${MYSQL_PASSWORD} cleanup" > ./sysbench_cleanup.sh
chmod +x ./sysbench_*

#########
## this part is not automatic yet, need to script this out
#########
# find mysql password
grep 'A temporary password is generated for root@localhost' /var/log/mysqld.log |tail -1
# change mysql root password
#SET PASSWORD = PASSWORD('pass11PP**');
# create database sysbench
#CREATE DATABASE sysbench;


