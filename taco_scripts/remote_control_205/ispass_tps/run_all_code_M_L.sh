#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        reboot -k kernel
EOF
sleep 180

#ssh root@10.79.20.116 <<EOF
#        cd /home/xd10/tests/mysql
#        cpuset -c -l 2,3,4,5 mysql-server onestart
#        ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=5000000 --events=160000 --time=6000 run
#        mysql-server onestop
#        cpuset -c -l 2,3,4,5 mysql-server onestart
#        ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=5000000 --events=1600000 --time=6000 run
#        cpuset -c -l 7 ./run_top.sh M_L 1.2G 5000000 kernel 
#EOF
#sleep 180
#
#ssh root@10.79.20.116 << EOF
#        cd /usr/home/xd10/tests/postgres
#        mkdir -p results/postgres_320s_selectonly_10c_3000000t_2core_M_L_116_usr_1/ 
#        cpuset -c -l 2,3,4,5 postgresql onestart
#        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 1000 -S pgbench320s -h 10.79.20.116 -U root
#        postgresql onestop
#        cpuset -c -l 2,3,4,5 postgresql onestart
#        ssh -n yz70@virt02-rca.cs.rice.edu pgbench -C -j 2 -c 10 -t 10000 -S pgbench320s -h 10.79.20.116 -U root
#        cpuset -c -l 7 ./run.sh 10 M_L_connect 320 >& results/out.txt
#        mv results/out.txt results/postgres_320s_selectonly_10c_3000000t_2core_M_L_connect_116_usr_1/
#        reboot -k kernel
#EOF
#sleep 180
#
#
#ssh root@10.79.20.116 << EOF
#	cd /home/xd10/tests/java
#        cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 500 -Dspecjvm.hardware.threads.override=4 derby
#        cpuset -c -l 7 ./run_derby_nosuperpg_promo.sh L_J >& results/out.txt
#        mv results/out.txt results/java_ld_derby_500ops_L_J_usr_2/
#	reboot -k kernel
#EOF
#sleep 180
#
#ssh root@10.79.20.116 << EOF
#	cd /home/xd10/tests/java
#        cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 500 -Dspecjvm.hardware.threads.override=4 compiler.compiler
#        cpuset -c -l 7 ./run_compiler_nosuperpg_promo.sh L_J >& results/out.txt
#        mv results/out.txt results/java_ld_compiler_500ops_L_J_usr_2/
#	reboot -k kernel
#EOF
#sleep 180
#
#
#ssh root@10.79.20.116 << EOF
#        cd /home/xd10/tests/nodejs/node_modules/react-ssr-benchmarks
#        cpuset -c -l 2,3,4,5 node index.js >& /dev/null
#        cpuset -c -l 7 ./run.sh M_L >& /home/xd10/tests/nodejs/results/out.txt
#        mv /home/xd10/tests/nodejs/results/out.txt /home/xd10/tests/nodejs/results/node_reactssr_ld_1500iter_6thrd_M_L_116_usr_1/
#        reboot -k kernel
#EOF
#sleep 180

ssh root@10.79.20.116 << EOF
        cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh M_L >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_M_L_116_usr_1/
        reboot -k kernel
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
	dd if=/usr/bin/clang of=/dev/null
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh Ms_L >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_Ms_L_116_usr_1/
        reboot -k kernel
EOF
sleep 180
