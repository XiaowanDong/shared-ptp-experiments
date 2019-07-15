#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        reboot -k kernel
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	sysctl kern.elf64.round_2m=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_Ms_L_padding_connect_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 1000 -S pgbench320s -h 10.79.20.116 -U root
        dd if=/usr/local/bin/postgres of=/dev/null
	postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 10000 -S pgbench320s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_L_padding_connect 320 >& results/out.txt
        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_Ms_L_padding_connect_116_usr_1/
	reboot -k kernel.final_sptp_lib
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_Ms_Lt_connect_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 1000 -S pgbench320s -h 10.79.20.116 -U root
        dd if=/usr/local/bin/postgres of=/dev/null
	postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 10000 -S pgbench320s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_Lt_connect 320 >& results/out.txt
        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_Ms_Lt_connect_116_usr_1/
	reboot -k kernel.final_sptp_lib
EOF
sleep 180

ssh root@10.79.20.116 << EOF
	sysctl kern.elf64.round_2m=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_Ms_Lt_padding_connect_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 1000 -S pgbench320s -h 10.79.20.116 -U root
        dd if=/usr/local/bin/postgres of=/dev/null
	postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 10000 -S pgbench320s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_Lt_padding_connect 320 >& results/out.txt
        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_Ms_Lt_padding_connect_116_usr_1/
	reboot -k kernel
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_Ms_L_connect_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 1000 -S pgbench320s -h 10.79.20.116 -U root
        dd if=/usr/local/bin/postgres of=/dev/null
	postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 10000 -S pgbench320s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 Ms_L_connect 320 >& results/out.txt
        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_Ms_L_connect_116_usr_1/
	reboot -k kernel
EOF
sleep 180


