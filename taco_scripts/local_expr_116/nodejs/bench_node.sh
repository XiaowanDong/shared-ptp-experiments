#!/usr/local/bin/bash -x

EVENTS=$1
EVENT_GRP_ID=$2
TEST_NAME=$3
ITER=$4
RESULTS_DIR=/home/xd10/tests/nodejs/results/$TEST_NAME

cpuset -c -l 7 pmcstat -C -c 2,3,4,5 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
pmcpid=$!
sleep 11
(time cpuset -c -l 2,3,4,5 ./loop_node.sh) >& "$RESULTS_DIR"/time_1_"$EVENT_GRP_ID"_"$ITER" &
pid1=$!

(time cpuset -c -l 2,3,4,5 ./loop_node.sh) >& "$RESULTS_DIR"/time_2_"$EVENT_GRP_ID"_"$ITER" &
pid2=$!

(time cpuset -c -l 2,3,4,5 ./loop_node.sh) >& "$RESULTS_DIR"/time_3_"$EVENT_GRP_ID"_"$ITER" &
pid3=$!

(time cpuset -c -l 2,3,4,5 ./loop_node.sh) >& "$RESULTS_DIR"/time_4_"$EVENT_GRP_ID"_"$ITER" &
pid4=$!

#time -o "$RESULTS_DIR"/time_5_"$EVENT_GRP_ID"_"$ITER" cpuset -c -l 2,3,4,5 ./loop_node.sh &
#pid5=$!

#time -o "$RESULTS_DIR"/time_6_"$EVENT_GRP_ID"_"$ITER" cpuset -c -l 2,3,4,5 ./loop_node.sh &
#pid6=$!

wait $pid1
wait $pid2
wait $pid3
wait $pid4
#wait $pid5
#wait $pid6
sleep 11
kill $pmcpid
wait $pmcpid
