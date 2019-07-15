#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        reboot -k kernel_all
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	sysctl vm.pmap.nxpg_ps_disabled=1
	sysctl vm.fast_nxpg_ps_disabled=1
	sysctl vm.pmap.xpg_ps_disabled=2
	sysctl vm.fast_xpg_ps_disabled=1
	cd /home/xd10/tests/java
	cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch  -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 400 -Dspecjvm.hardware.threads.override=4 derby
	cpuset -c -l 7 ./run_derby_nosuperpg_promo.sh L_J_nosuperpg >& results/out.txt
	mv results/out.txt results/java_ld_derby_500ops_L_J_nosuperpg_usr_2/
	reboot -k kernel_all
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	sysctl vm.pmap.nxpg_ps_disabled=1
	sysctl vm.fast_nxpg_ps_disabled=1
	cd /home/xd10/tests/java
	cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch  -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 400 -Dspecjvm.hardware.threads.override=4 derby
	cpuset -c -l 7 ./run_derby_nosuperpg_promo.sh Ls_Js_data_nosuperpg >& results/out.txt
	mv results/out.txt results/java_ld_derby_500ops_Ls_Js_data_nosuperpg_usr_2/
	reboot -k agg-data-superpg
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	kldload /home/xd10/hwpmc.ko
        sysctl vm.reserv.wakeup_frequency=1
        sysctl vm.reserv.wakeup_time=20
        sysctl vm.reserv.pop_budget=200
        sysctl vm.reserv.pop_threshold=0
        sysctl vm.reserv.enable_prezero=1
	sysctl vm.pmap.xpg_ps_disabled=2
	sysctl vm.fast_xpg_ps_disabled=1
	cd /home/xd10/tests/java
	cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -XX:CodeCacheExpansionSize=2m -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 400 -Dspecjvm.hardware.threads.override=4 derby
	dd if=/usr/local/bootstrap-openjdk8/jre/lib/amd64/server/libjvm.so of=/dev/null
	cpuset -c -l 7 ./run_derby.sh L-s_J-s_data_superpg >& results/out.txt
	mv results/out.txt results/java_ld_derby_500ops_L-s_J-s_data_superpg_usr_2/
	reboot -k agg-data-superpg
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	kldload /home/xd10/hwpmc.ko
        sysctl vm.reserv.wakeup_frequency=1
        sysctl vm.reserv.wakeup_time=20
        sysctl vm.reserv.pop_budget=200
        sysctl vm.reserv.pop_threshold=0
        sysctl vm.reserv.enable_prezero=1
	cd /home/xd10/tests/java
	cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -XX:CodeCacheExpansionSize=2m -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 400 -Dspecjvm.hardware.threads.override=4 derby
	dd if=/usr/local/bootstrap-openjdk8/jre/lib/amd64/server/libjvm.so of=/dev/null
	cpuset -c -l 7 ./run_derby.sh Ls_Js_data_superpg >& results/out.txt
	mv results/out.txt results/java_ld_derby_500ops_Ls_Js_data_superpg_usr_2/
	reboot -k kernel_all
EOF
sleep 180

