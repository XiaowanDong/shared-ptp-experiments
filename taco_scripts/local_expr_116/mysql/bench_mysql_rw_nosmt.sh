#!/usr/local/bin/bash -x

EVENTS=$1
EVENT_GRP_ID=$2
TEST_NAME=$3
ITER=$4
TABLE_SIZE=$5
RESULTS_DIR=/home/xd10/tests/mysql/results/$TEST_NAME

mkdir -p "$RESULTS_DIR"
cpuset -c -l 3 pmcstat -C -c 1,2 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
pmcpid=$!
sleep 11
ssh yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$TABLE_SIZE --events=1600000 --time=6000 run
#ssh yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=1 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=5000000 --events=100000 --time=6000 run
sleep 11
kill $pmcpid
wait $pmcpid
