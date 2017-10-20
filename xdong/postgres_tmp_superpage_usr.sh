#!/bin/sh

TEST_NAME=postgres
RESULTS_DIR=results/$TEST_NAME
rm -rf $RESULTS_DIR/hw_results*
mkdir -p $RESULTS_DIR

#cpuset -c -l 4,5 /usr/local/etc/rc.d/postgresql restart
#pgbench -i -s 300 pgbench #16GB database: scale/75 = 1GB

NUM=0
for EVENT in \
    "-s instruction-retired,usr \
    -s CPU_CLK_UNHALTED.THREAD_P,usr \
    -s ITLB_MISSES.WALK_COMPLETED,usr \
    -s DTLB_LOAD_MISSES.WALK_COMPLETED,usr" \
    "-s L2_RQSTS.MISS,os" 
do
   let NUM+=1
   #echo $EVENT $NUM
   ./bench_$TEST_NAME.sh "$EVENT" $NUM
done
