#!/usr/local/bin/bash -x

EVENTS=$1
EVENT_GRP_ID=$2
TEST_NAME=$3
ITER=$4
RESULTS_DIR=/root/tests/clang/results/$TEST_NAME

cpuset -c -l 7 pmcstat -C -c 1,2 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
pmcpid=$!
sleep 11
cd /root/tests/clang/src1
(time cpuset -c -l 1 ./test_dhrystone.sh) >& "$RESULTS_DIR"/time_1_"$EVENT_GRP_ID"_"$ITER" &
pid1=$!

cd /root/tests/clang/src2
(time cpuset -c -l 2 ./test_dhrystone.sh) >& "$RESULTS_DIR"/time_2_"$EVENT_GRP_ID"_"$ITER" &
pid2=$!

wait $pid1
wait $pid2
sleep 11
kill $pmcpid
wait $pmcpid
