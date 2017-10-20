#!/bin/sh

TEST_NAME=postgres
RESULTS_DIR=results/$TEST_NAME
rm -rf $RESULTS_DIR/hw_results*
mkdir -p $RESULTS_DIR


dd if=/usr/local/bin/postgres of=/dev/null
cpuset -c -l 4,5 /usr/local/etc/rc.d/postgresql restart
pgbench -i -s 300 pgbench #16GB database: scale/75 = 1GB

NUM=3
for EVENT in \
    #"-s instruction-retired,os \
    #-s CPU_CLK_UNHALTED.THREAD_P,os \
    #-s ITLB_MISSES.WALK_COMPLETED,os \
    #-s DTLB_LOAD_MISSES.WALK_COMPLETED,os" \
    #"-s L2_RQSTS.MISS,os" 
    "-s ITLB_MISSES.WALK_PENDING,os \
    -s DTLB_LOAD_MISSES.WALK_PENDING,os \
    -s DTLB_STORE_MISSES.WALK_PENDING,os \
    -s CYCLE_ACTIVITY.CYCLES_L3_MISS,os"
do
   let NUM+=1
   #echo $EVENT $NUM
   ./bench_$TEST_NAME.sh "$EVENT" $NUM
done
