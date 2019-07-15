#!/usr/local/bin/bash -x

EVENTS=$1
EVENT_GRP_ID=$2
TEST_NAME=$3
ITER=$4
RESULTS_DIR=/home/xd10/tests/java/results/$TEST_NAME

cpuset -c -l 7 pmcstat -C -c 2,3,4,5 $EVENTS -o "$RESULTS_DIR"/hw_results_"$EVENT_GRP_ID"_"$ITER" &
pmcpid=$!
sleep 11
cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -XX:CodeCacheExpansionSize=2m -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 500 -Dspecjvm.hardware.threads.override=4 compiler.compiler
sleep 11
kill $pmcpid
wait $pmcpid
