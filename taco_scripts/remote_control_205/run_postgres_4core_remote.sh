#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_$2c_1000000t_4core_M_L_116_usr_1/ 
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c $2 -t 500000 -S pgbench$1s -h 10.79.20.116 -U root
        postgresql onestop
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c $2 -t 2000000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh $2 M_L $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_$2c_1000000t_4core_M_L_116_usr_1/
        reboot
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_$2c_1000000t_4core_Ms_L_116_usr_1/ 
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c $2 -t 500000 -S pgbench$1s -h 10.79.20.116 -U root
	dd if=/usr/local/bin/postgres of=/dev/null
        postgresql onestop
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c $2 -t 2000000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh $2 Ms_L $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_$2c_1000000t_4core_Ms_L_116_usr_1/
        reboot
EOF
sleep 180


ssh root@10.79.20.116 << EOF
	sysctl kern.elf64.round_2m=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_$1s_selectonly_$2c_1000000t_4core_Msp_L_116_usr_1/ 
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c $2 -t 500000 -S pgbench$1s -h 10.79.20.116 -U root
	dd if=/usr/local/bin/postgres of=/dev/null
        postgresql onestop
        postgresql onestart
        ssh yz70@virt02-rca.cs.rice.edu pgbench -j 4 -c $2 -t 2000000 -S pgbench$1s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh $2 Msp_L $1 >& results/out.txt
        mv results/out.txt results/postgres_$1s_selectonly_$2c_1000000t_4core_Msp_L_116_usr_1/
        reboot
EOF
sleep 180


