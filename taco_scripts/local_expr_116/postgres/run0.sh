#!/usr/local/bin/bash -x

#TEST_NAME=postgres_lld_1G_selectonly_5000000t_2core_Ms_L_usr_1
#TEST_NAME=postgres_lld_1G_selectonly_5000000t_connect_2core_Ms_L_usr_1
#TEST_NAME=postgres_ld_1G_selectonly_80000t_connect_3core_Msp_Lt_116_usr_1
#TEST_NAME=postgres_ld_256s_selectonly_50000t_connect_4core_Msp_Lt_116_usr_1
#TEST_NAME=postgres_640s_selectonly_3000000t_4core_Msp_Lt_116_usr_1
TEST_NAME=postgres_$3s_selectonly_$1c_3000000t_2core_$2_116_usr_1
RESULTS_DIR=/usr/home/xd10/tests/postgres/results/$TEST_NAME
TOTAL_ITERS=3

mkdir -p "$RESULTS_DIR"

/root/tests/record_env.sh /usr/local/bin/postgres > "$RESULTS_DIR"/env_"$TEST_NAME".txt 2>&1
cpuset -g -p "$(head -n1 ~postgres/data96/postmaster.pid)" > "$RESULTS_DIR"/cpuset_"$TEST_NAME".txt 2>&1
cp /etc/rc.conf "$RESULTS_DIR"/rc.conf_"$TEST_NAME".txt
cp ~postgres/data96/postgresql.conf "$RESULTS_DIR"/postgresql.conf_"$TEST_NAME".txt
ITER=0
while [ $ITER -lt $TOTAL_ITERS ]; do
	procstat -v "$(head -n1 ~postgres/data96/postmaster.pid)" > "$RESULTS_DIR"/procstat_"$TEST_NAME"_"$ITER"_before.txt 2>&1
	cp /var/log/messages "$RESULTS_DIR"/messages_"$TEST_NAME"_"$ITER"_before.txt
	NUM=0
	for EVENTS in \
		"-s CPU_CLK_UNHALTED.THREAD_P,usr \
                -s DTLB_LOAD_MISSES.WALK_COMPLETED,usr \
                -s DTLB_LOAD_MISSES.WALK_PENDING,usr \
                -s DTLB_STORE_MISSES.WALK_COMPLETED,usr" \
                "-s DTLB_STORE_MISSES.WALK_PENDING,usr \
                -s ITLB_MISSES.WALK_COMPLETED,usr \
                -s ITLB_MISSES.WALK_PENDING,usr \
                -s ICACHE_64B.IFTAG_STALL,usr" \
               "-s CPU_CLK_UNHALTED.THREAD_P \
               -s INST_RETIRED.ANY_P \
               -s INST_RETIRED.ANY_P,usr \
               -s CYCLE_ACTIVITY.STALLS_L3_MISS,cmask=6,usr" \
               "-s CYCLE_ACTIVITY.STALLS_MEM_ANY,cmask=20,usr \
               -s CYCLE_ACTIVITY.STALLS_L1D_MISS,cmask=12,usr \
               -s CYCLE_ACTIVITY.STALLS_L2_MISS,cmask=5,usr \
               -s ITLB.ITLB_FLUSH,usr" 

	do
		((NUM++))
		./bench_postgres_connect.sh "$EVENTS" $NUM $TEST_NAME $ITER $1 $3
	done

	procstat -v "$(head -n1 ~postgres/data96/postmaster.pid)" > "$RESULTS_DIR"/procstat_"$TEST_NAME"_"$ITER"_after.txt 2>&1
	cp /var/log/messages "$RESULTS_DIR"/messages_"$TEST_NAME"_"$ITER"_after.txt
	vmstat -s > "$RESULTS_DIR"/vmstat_"$TEST_NAME"_"$ITER"_after.txt
    ((ITER++))
done
