#!/usr/local/bin/bash -x

EVENTS=$1
EVENT_GRP_ID=$2
TEST_NAME=$3
ITER=$4
RESULTS_DIR=/home/xd10/tests/clang/results/$TEST_NAME

cpuset -c -l 7 pmcstat -C -c 2,3,4,5 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
pmcpid=$!
sleep 11
cd /home/xd10/tests/clang/src1
(time cpuset -c -l 2 ./test_dhrystone.sh) >& "$RESULTS_DIR"/time_1_"$EVENT_GRP_ID"_"$ITER" &
pid1=$!

cd /home/xd10/tests/clang/src2
(time cpuset -c -l 3 ./test_dhrystone.sh) >& "$RESULTS_DIR"/time_2_"$EVENT_GRP_ID"_"$ITER" &
pid2=$!

cd /home/xd10/tests/clang/src3
(time cpuset -c -l 4 ./test_dhrystone.sh) >& "$RESULTS_DIR"/time_3_"$EVENT_GRP_ID"_"$ITER" &
pid3=$!

cd /home/xd10/tests/clang/src4
(time cpuset -c -l 5 ./test_dhrystone.sh) >& "$RESULTS_DIR"/time_4_"$EVENT_GRP_ID"_"$ITER" &
pid4=$!

wait $pid1
wait $pid2
wait $pid3
wait $pid4
sleep 11
kill $pmcpid
wait $pmcpid
