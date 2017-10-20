#! /usr/local/bin/bash

EVENT=$1
TEST_NAME=postgres
RESULTS_DIR=results/$TEST_NAME
TOTAL_ITERS=6

#pgbench -i -s 900 pgbench #16GB database: scale/75 = 1GB
#cpuset -c -l 4,5 /usr/local/etc/rc.d/postgresql restart 

ITER=1
while [ $ITER -lt $TOTAL_ITERS ]; do
	cpuset -c -l 2,3 pmcstat -C -c 4,5 $EVENT -o $RESULTS_DIR/hw_results_$2_$ITER &
	pmcpid=$!
	cpuset -c -l 6,7 pgbench -j 1 -c 2 -t 4000000 -S pgbench
	kill $pmcpid
	wait $pmcpid

	let ITER+=1
done

