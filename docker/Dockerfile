FROM mysql:5.7

# TO USE:
# 1. customize ENV's below
# 2. start container and it will create databases (could take minutes or longer)
# 3. run /opt/sysbench_run.sh to kick off a test run

# NOTE: mysql has a VOLUME at /var/lib/mysql
# so you may want to customize the volume storage for that or bind-mount to host

##
## install sysbench
##

RUN set -x \
        && apt-get update \
        && apt-get install -y --no-install-recommends git ca-certificates automake libtool \
        make vim pkg-config libmysqlclient-dev \
        && git clone https://github.com/akopytov/sysbench.git \
        && cd sysbench && ./autogen.sh && ./configure && make \
        && cp sysbench/sysbench /usr/local/bin/ \
        && apt-get purge -y --auto-remove ca-certificates automake libtool make vim pkg-config \
        && rm -rf /var/lib/apt/lists/*


##
## change these values to your environment and needs
#######################
ENV SYSBENCH_TABLE_SIZE=1000000 \
    SYSBENCH_TABLE_COUNT=3 \
    SYSBENCH_NUM_THREADS=40 \
    SYSBENCH_MAX_TIME=1200 \
    SYSBENCH_MAX_REQUESTS=1000000

# mysql_buffersize should be 60-80% of memory
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true \
    MYSQL_DATABASE=sysbench \
    MYSQL_CONFIG=/etc/mysql/mysql.conf.d/mysqld.cnf \
    MYSQL_BUFFERSIZE=2G \
    MYSQL_LOGSIZE=512M \
    MYSQL_FLUSHLOG=1 \
    MYSQL_FLUSHMETHOD=O_DIRECT
#######################


RUN echo "innodb_buffer_pool_size = ${MYSQL_BUFFERSIZE}" >> ${MYSQL_CONFIG} && \
    echo "innodb_log_file_size = ${MYSQL_LOGSIZE}" >> ${MYSQL_CONFIG} && \
    echo "innodb_flush_log_at_trx_commit = ${MYSQL_FLUSHLOG}" >> ${MYSQL_CONFIG} && \
    echo "innodb_flush_method = ${MYSQL_FLUSHMETHOD}" >> ${MYSQL_CONFIG}


# this will create DB's on container start, and may take some time depending on your ENV's above
RUN echo 'sysbench --test=/sysbench/tests/include/oltp_legacy/oltp.lua --oltp-tables-count=${SYSBENCH_TABLE_COUNT} --oltp-table-size=${SYSBENCH_TABLE_SIZE} --mysql-db=${MYSQL_DATABASE} --mysql-user=root prepare' > /docker-entrypoint-initdb.d/sysbench_prepare.sh && \
    chmod +x /docker-entrypoint-initdb.d/sysbench_prepare.sh


# run /opt/sysbench_run.sh to start a single test run
RUN echo 'sysbench --test=/sysbench/tests/include/oltp_legacy/oltp.lua --oltp-tables-count=${SYSBENCH_TABLE_COUNT} --oltp-table-size=${SYSBENCH_TABLE_SIZE} --oltp-test-mode=complex --num-threads=${SYSBENCH_NUM_THREADS} --max-time=${SYSBENCH_MAX_TIME} --max-requests=${SYSBENCH_MAX_REQUESTS} --mysql-db=${MYSQL_DATABASE} --mysql-user=root run' > /opt/sysbench_run.sh && \
    chmod +x /opt/sysbench_run.sh
