#! /usr/local/bin/bash

# Run sysctl kern.sched.topology_spec to check if CPU topology is sane.

EVENT=$1
TEST_NAME=clang
#PROFILES_DIR=/root/ITLB_MISSES.WALK_DURATION
RESULTS_DIR=results/$TEST_NAME
TOTAL_ITERS=6

ITER=1
while [ $ITER -lt $TOTAL_ITERS ]; do
	cpuset -c -l 2,3 pmcstat -C -c 4,5 $EVENT -o $RESULTS_DIR/hw_results_$2_$ITER &
  	pmcpid=$!
	cpuset -c -l 4 ./test_clang.sh &
	cpid1=$!
	cpuset -c -l 5 ./test_clang.sh &
	cpid2=$!
	wait $cpid1
	wait $cpid2
	kill $pmcpid
	wait $pmcpid	

	let ITER+=1
done

