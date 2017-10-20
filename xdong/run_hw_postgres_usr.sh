#!/bin/sh

TEST_NAME=postgres
RESULTS_DIR=results/$TEST_NAME
#rm -rf $RESULTS_DIR/hw_results*
mkdir -p $RESULTS_DIR

#cpuset -c -l 4,5 /usr/local/etc/rc.d/postgresql restart
#pgbench -i -s 300 pgbench #16GB database: scale/75 = 1GB

NUM=0
for EVENT in \
    "-s PAGE_FAULT.ALL,usr \
    -s instruction-retired,usr \
    -s CPU_CLK_UNHALTED.THREAD_P,usr \
    -s ITLB_MISSES.MISS_CAUSES_A_WALK,usr" \
    "-s ITLB_MISSES.WALK_COMPLETED,usr \
    -s ITLB_MISSES.WALK_PENDING,usr \
    -s ITLB_MISSES.STLB_HIT,usr \
    -s DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK,usr" \
    "-s DTLB_LOAD_MISSES.WALK_COMPLETED,usr \
    -s DTLB_LOAD_MISSES.WALK_PENDING,usr \
    -s DTLB_LOAD_MISSES.STLB_HIT,usr \
    -s DTLB_STORE_MISSES.MISS_CAUSES_A_WALK,usr" \
    "-s DTLB_STORE_MISSES.WALK_COMPLETED,usr \
    -s DTLB_STORE_MISSES.WALK_PENDING,usr \
    -s DTLB_STORE_MISSES.STLB_HIT,usr \
    -s MEM_UOPS_RETIRED.STLB_MISS_LOADS,usr" \
    "-s MEM_UOPS_RETIRED.STLB_MISS_STORES,usr \
    -s L1D_PEND_MISS.PENDING,usr \
    -s L2_RQSTS.DEMAND_DATA_RD_MISS,usr \
    -s L2_RQSTS.RFO_MISS,usr" \
    "-s L2_RQSTS.CODE_RD_MISS,usr \
    -s L2_RQSTS.ALL_DEMAND_MISS,usr \
    -s L2_RQSTS.PF_MISS,usr \
    -s L2_RQSTS.MISS,usr" \
    "-s llc-misses,usr \
    -s OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD,usr \
    -s CYCLE_ACTIVITY.CYCLES_L1D_MISS,usr \
    -s CYCLE_ACTIVITY.CYCLES_L2_MISS,usr" \
    "-s CYCLE_ACTIVITY.CYCLES_L3_MISS,usr \
    -s CYCLE_ACTIVITY.CYCLES_MEM_ANY,usr \
    -s MEM_UOPS_RETIRED.ALL_LOADS,usr \
    -s MEM_UOPS_RETIRED.ALL_STORES,usr" \
    "-s ITLB.ITLB_FLUSH,usr"
do
   let NUM+=1
   #echo $EVENT $NUM
   ./bench_$TEST_NAME.sh "$EVENT" $NUM
done
