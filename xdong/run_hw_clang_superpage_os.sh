#!/bin/sh

TEST_NAME=clang
RESULTS_DIR=results/$TEST_NAME
#rm -rf $RESULTS_DIR/hw_results*
mkdir -p $RESULTS_DIR

/usr/bin/clang -v
dd if=/usr/bin/clang of=/dev/null

NUM=0
for EVENT in \
    "-s PAGE_FAULT.ALL,os \
    -s instruction-retired,os \
    -s CPU_CLK_UNHALTED.THREAD_P,os \
    -s ITLB_MISSES.MISS_CAUSES_A_WALK,os" \
    "-s ITLB_MISSES.WALK_COMPLETED,os \
    -s ITLB_MISSES.WALK_PENDING,os \
    -s ITLB_MISSES.STLB_HIT,os \
    -s DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK,os" \
    "-s DTLB_LOAD_MISSES.WALK_COMPLETED,os \
    -s DTLB_LOAD_MISSES.WALK_PENDING,os \
    -s DTLB_LOAD_MISSES.STLB_HIT,os \
    -s DTLB_STORE_MISSES.MISS_CAUSES_A_WALK,os" \
    "-s DTLB_STORE_MISSES.WALK_COMPLETED,os \
    -s DTLB_STORE_MISSES.WALK_PENDING,os \
    -s DTLB_STORE_MISSES.STLB_HIT,os \
    -s MEM_UOPS_RETIRED.STLB_MISS_LOADS,os" \
    "-s MEM_UOPS_RETIRED.STLB_MISS_STORES,os \
    -s L1D_PEND_MISS.PENDING,os \
    -s L2_RQSTS.DEMAND_DATA_RD_MISS,os \
    -s L2_RQSTS.RFO_MISS,os" \
    "-s L2_RQSTS.CODE_RD_MISS,os \
    -s L2_RQSTS.ALL_DEMAND_MISS,os \
    -s L2_RQSTS.PF_MISS,os \
    -s L2_RQSTS.MISS,os" \
    "-s llc-misses,os \
    -s OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD,os \
    -s CYCLE_ACTIVITY.CYCLES_L1D_MISS,os \
    -s CYCLE_ACTIVITY.CYCLES_L2_MISS,os" \
    "-s CYCLE_ACTIVITY.CYCLES_L3_MISS,os \
    -s CYCLE_ACTIVITY.CYCLES_MEM_ANY,os \
    -s MEM_UOPS_RETIRED.ALL_LOADS,os \
    -s MEM_UOPS_RETIRED.ALL_STORES,os" \
    "-s ITLB.ITLB_FLUSH,os"
do
   let NUM+=1
   #echo $EVENT $NUM
   ./bench_$TEST_NAME.sh "$EVENT" $NUM
done
