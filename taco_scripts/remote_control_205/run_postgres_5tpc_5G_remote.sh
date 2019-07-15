#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
	kldload hwpmc.ko
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_64s_selectonly_10c_3000000t_2core_M_L_116_usr_1/ 
        cpuset -c -l 0,1,2,3 postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 250000 -S pgbench64s -h 10.79.20.116 -U root
        postgresql onestop
        cpuset -c -l 0,1,2,3 postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 3000000 -S pgbench64s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 M_L 64 >& results/out.txt
        mv results/out.txt results/postgres_64s_selectonly_10c_3000000t_2core_M_L_116_usr_1/
        reboot -k agg-data-superpg
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	kldload hwpmc.ko
	sysctl vm.reserv.wakeup_frequency=1
	sysctl vm.reserv.pop_budget=10
	sysctl vm.reserv.enable_prezero=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_64s_selectonly_10c_3000000t_2core_M_L_data_116_usr_1/ 
        cpuset -c -l 0,1,2,3 postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 250000 -S pgbench64s -h 10.79.20.116 -U root
        postgresql onestop
        cpuset -c -l 0,1,2,3 postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 3000000 -S pgbench64s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 M_L_data 64 >& results/out.txt
        mv results/out.txt results/postgres_64s_selectonly_10c_3000000t_2core_M_L_data_116_usr_1/
        reboot -k agg-data-superpg
EOF
sleep 180



ssh root@10.79.20.116 << EOF
	kldload hwpmc.ko
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_64s_selectonly_10c_3000000t_2core_Ms_L_116_usr_1/ 
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 250000 -S pgbench64s -h 10.79.20.116 -U root
	dd if=/usr/local/bin/postgres of=/dev/null
        postgresql onestop
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 3000000 -S pgbench64s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_L_data 64 >& results/out.txt
        mv results/out.txt results/postgres_64s_selectonly_10c_3000000t_2core_Ms_L_116_usr_1/
        reboot -k agg-data-superpg
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	kldload hwpmc.ko
	sysctl vm.reserv.enable_prezero=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_64s_selectonly_10c_3000000t_2core_Ms_L_data_116_usr_1/ 
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 250000 -S pgbench64s -h 10.79.20.116 -U root
	dd if=/usr/local/bin/postgres of=/dev/null
        postgresql onestop
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 3000000 -S pgbench64s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_L_data 64 >& results/out.txt
        mv results/out.txt results/postgres_64s_selectonly_10c_3000000t_2core_Ms_L_data_116_usr_1/
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


