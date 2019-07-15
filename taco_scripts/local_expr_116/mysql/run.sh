#!/usr/local/bin/bash -x

TEST_NAME=mysql_ld_$2_1600000t_ro_4thrd_$1_usr_116_3
RESULTS_DIR=/home/xd10/tests/mysql/results/$TEST_NAME
TOTAL_ITERS=3
TABLE_SIZE=$3

mkdir -p "$RESULTS_DIR"

/root/tests/record_env.sh /usr/local/libexec/mysqld > "$RESULTS_DIR"/env_"$TEST_NAME".txt 2>&1
cpuset -g -p "$(cat /var/db/mysql/virt09.pid)" > "$RESULTS_DIR"/cpuset_"$TEST_NAME".txt 2>&1
cp /etc/rc.conf "$RESULTS_DIR"/rc.conf_"$TEST_NAME".txt
cp /usr/local/etc/mysql/my.cnf "$RESULTS_DIR"/my.cnf_"$TEST_NAME".txt
ITER=0
while [ $ITER -lt $TOTAL_ITERS ]; do
	procstat -v "$(cat /var/db/mysql/virt09.pid)" > "$RESULTS_DIR"/procstat_"$TEST_NAME"_"$ITER"_before.txt 2>&1
	cp /var/log/messages "$RESULTS_DIR"/messages_"$TEST_NAME"_"$ITER"_before.txt
	NUM=0
	for EVENTS in \
		"-s DTLB_LOAD_MISSES.WALK_PENDING,os \
                -s DTLB_STORE_MISSES.WALK_PENDING,os \
                -s ITLB_MISSES.WALK_PENDING,os \
                -s ICACHE_64B.IFTAG_STALL,os" \
		"-s ICACHE_64B.IFTAG_STALL \
               -s CPU_CLK_UNHALTED.THREAD_P \
               -s INST_RETIRED.ANY_P \
               -s CPU_CLK_UNHALTED.THREAD_P,os"
#		"-s CPU_CLK_UNHALTED.THREAD_P,usr \
#                -s DTLB_LOAD_MISSES.WALK_PENDING,usr \
#                -s DTLB_STORE_MISSES.WALK_PENDING,usr \
#                -s ITLB_MISSES.WALK_PENDING,usr" \
#                "-s ICACHE_64B.IFTAG_STALL,usr \
#               -s CPU_CLK_UNHALTED.THREAD_P \
#               -s INST_RETIRED.ANY_P \
#               -s INST_RETIRED.ANY_P,usr"
#               "-s CPU_CLK_UNHALTED.THREAD_P \
#               -s INST_RETIRED.ANY_P \
#               -s INST_RETIRED.ANY_P,usr \
#               -s CYCLE_ACTIVITY.STALLS_L3_MISS,cmask=6,usr" \
#               "-s CYCLE_ACTIVITY.STALLS_MEM_ANY,cmask=20,usr \
#               -s CYCLE_ACTIVITY.STALLS_L1D_MISS,cmask=12,usr \
#               -s CYCLE_ACTIVITY.STALLS_L2_MISS,cmask=5,usr \
#               -s ITLB.ITLB_FLUSH,usr" \

	do
		((NUM++))
		./bench_mysql.sh "$EVENTS" $NUM $TEST_NAME $ITER $TABLE_SIZE
	done

	procstat -v "$(cat /var/db/mysql/virt09.pid)" > "$RESULTS_DIR"/procstat_"$TEST_NAME"_"$ITER"_after.txt 2>&1
	cp /var/log/messages "$RESULTS_DIR"/messages_"$TEST_NAME"_"$ITER"_after.txt
	vmstat -s > "$RESULTS_DIR"/vmstat_"$TEST_NAME"_"$ITER"_after.txt
        ((ITER++))
done
