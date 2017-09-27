#! /usr/local/bin/bash

# Run sysctl kern.sched.topology_spec to check if CPU topology is sane.

EVENT=$1
TEST_NAME=clang
#PROFILES_DIR=/root/ITLB_MISSES.WALK_DURATION
RESULTS_DIR=results/$TEST_NAME
TOTAL_ITERS=5

ITER=1
while [ $ITER -lt $TOTAL_ITERS ]; do
	cpuset -c -l 0 ./test_clang.sh &
	pmcstat -C -c 0,1 $EVENT -o $RESULTS_DIR/hw_results_$2_$ITER cpuset -c -l 1 ./test_clang.sh 

	let ITER+=1
done

