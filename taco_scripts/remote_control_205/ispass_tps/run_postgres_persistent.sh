#!/usr/local/bin/bash -x

#ssh root@10.79.20.116 << EOF
#        reboot -k kernel
#EOF
#sleep 180

#ssh root@10.79.20.116 << EOF
#        cd /usr/home/xd10/tests/postgres
#	mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_M_L_116_usr_1/ 
#        cpuset -c -l 2,3,4,5 postgresql onestart
#        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 250000 -S pgbench320s -h 10.79.20.116 -U root
#        postgresql onestop
#        cpuset -c -l 2,3,4,5 postgresql onestart
#        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 3000000 -S pgbench320s -h 10.79.20.116 -U root
#        cpuset -c -l 7 ./run.sh 10 M_L 320 >& results/out.txt
#        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_M_L_116_usr_1/
#	reboot -k kernel-all
#EOF
#sleep 180

ssh root@10.79.20.116 << EOF
	sysctl vm.pmap.xpg_ps_disabled=2
        sysctl vm.fast_xpg_ps_disabled=1
        cd /usr/home/xd10/tests/postgres
	mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_M-s_L_116_usr_1/ 
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 250000 -S pgbench320s -h 10.79.20.116 -U root
        postgresql onestop
        cpuset -c -l 2,3,4,5 postgresql onestart
        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -j 2 -c 10 -t 3000000 -S pgbench320s -h 10.79.20.116 -U root
        cpuset -c -l 7 ./run.sh 10 M-s_L 320 >& results/out.txt
        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_M-s_L_116_usr_1/
	reboot -k kernel
EOF
sleep 180


