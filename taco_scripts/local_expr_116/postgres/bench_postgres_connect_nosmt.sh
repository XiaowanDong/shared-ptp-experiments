#!/usr/local/bin/bash -x

EVENTS=$1
EVENT_GRP_ID=$2
TEST_NAME=$3
ITER=$4
CLIENTS_NUM=$5
RESULTS_DIR=/usr/home/xd10/tests/postgres/results/$TEST_NAME
DATABASE=pgbench$6s

mkdir -p $RESULTS_DIR
cpuset -c -l 7 pmcstat -C -c 1,2 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
#cpuset -c -l 7 pmcstat -C -c 0,1,2,3 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
pmcpid=$!
sleep 11
ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c $CLIENTS_NUM -t 20000 -S $DATABASE -h 10.79.20.116 -U root
#cpuset -c -l 7 pgbench -j 1 -c 8 -t 5000000 -S pgbench1G
sleep 11
kill $pmcpid
wait $pmcpid
