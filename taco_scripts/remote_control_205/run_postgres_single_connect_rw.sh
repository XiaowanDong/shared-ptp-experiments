#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        reboot -k kernel_all
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	sysctl vm.pmap.nxpg_ps_disabled=1
	sysctl vm.fast_nxpg_ps_disabled=1
        sysctl vm.pmap.xpg_ps_disabled=1
	sysctl vm.fast_xpg_ps_disabled=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_10c_3000000t_2core_M_L_nosuperpg_connect_rw_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
	./createdb.sh $1
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 1000 -S pgbench$1s -h 10.79.20.116 -U root
        postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 10000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 M_L_nosuperpg_connect_rw $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_10c_3000000t_2core_M_L_nosuperpg_connect_rw_116_usr_1/
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
        sysctl vm.pmap.xpg_ps_disabled=1
	sysctl vm.fast_xpg_ps_disabled=1
	sysctl vm.fast_nxpg_ps_disabled=0
	cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_10c_3000000t_2core_M_L_code_nosuperpg_data_superpg_connect_rw_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
	./createdb.sh $1
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 1000 -S pgbench$1s -h 10.79.20.116 -U root
        postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 10000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 M_L_code_nosuperpg_data_superpg_connect_rw $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_10c_3000000t_2core_M_L_code_nosuperpg_data_superpg_connect_rw_116_usr_1/
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
	sysctl vm.fast_nxpg_ps_disabled=0
	cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_10c_3000000t_2core_Ms_L_data_superpg_connect_rw_116_usr_1/ 
        postgresql onestart
	./createdb.sh $1
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 1000 -S pgbench$1s -h 10.79.20.116 -U root
	dd if=/usr/local/bin/postgres of=/dev/null
        postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 10000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_L_data_superpg_connect_rw $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_10c_3000000t_2core_Ms_L_data_superpg_connect_rw_116_usr_1/
        reboot -k kernel_all
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	sysctl vm.pmap.nxpg_ps_disabled=1
	sysctl vm.fast_nxpg_ps_disabled=1
	cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_10c_3000000t_2core_Ms_L_data_nosuperpg_connect_rw_116_usr_1/ 
        postgresql onestart
	./createdb.sh $1
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 1000 -S pgbench$1s -h 10.79.20.116 -U root
	dd if=/usr/local/bin/postgres of=/dev/null
        postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 --builtin=tpcb-like -c 10 -t 10000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_L_data_nosuperpg_connect_rw $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_10c_3000000t_2core_Ms_L_data_nosuperpg_connect_rw_116_usr_1/
        reboot
EOF
sleep 180



#ssh root@10.79.20.116 << EOF
#	sysctl kern.elf64.round_2m=1
#        cd /usr/home/xd10/tests/postgres
#	mkdir -p results/postgres_64s_selectonly_20c_3000000t_4core_Msp_L_116_usr_1/ 
#        postgresql onestart
#        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c 20 -t 250000 -S pgbench64s -h 10.79.20.116 -U root
#	dd if=/usr/local/bin/postgres of=/dev/null
#        postgresql onestop
#        postgresql onestart
#        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c 20 -t 3000000 -S pgbench64s -h 10.79.20.116 -U root
#        cpuset -c -l 7 ./run.sh 20 Msp_L 64 >& results/out.txt
#        mv results/out.txt results/postgres_64s_selectonly_20c_3000000t_4core_Msp_L_116_usr_1/
#        reboot
#EOF
#sleep 180


