#!/usr/local/bin/bash -x

#sysctl vm.pmap.xpg_ps_disabled=2
#sysctl vm.code_promo_thld=21
#sysctl vm.pmap.nxpg_ps_disabled=1


#ssh root@10.79.20.116 << EOF
#	reboot -k agg-data-superpg
#EOF
#sleep 180 
#
#ssh root@10.79.20.116 <<EOF
#	kldload /home/xd10/hwpmc.ko
#	sysctl vm.reserv.wakeup_frequency=1
#	sysctl vm.reserv.wakeup_time=20
#	sysctl vm.reserv.pop_budget=200
#	sysctl vm.reserv.pop_threshold=0
#	sysctl vm.reserv.enable_prezero=1
#	sysctl vm.pmap.xpg_ps_disabled=1
#	sysctl vm.fast_xpg_ps_disabled=1
#	sysctl vm.fast_nxpg_ps_disabled=0
#	cd /home/xd10/tests/mysql
#	cpuset -c -l 1,2 mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=160000 --time=6000 run
#	mysql-server onestop
#	cpuset -c -l 1,2 mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=1600000 --time=6000 run
#	cpuset -c -l 3 ./run_top.sh M_L_code_nosuperpg_data_superpg_rw_nosmt $1 $2 kernel_all
#	#mv results/out.txt results/mysql_ld_$1_1600000t_ro_4thrd_M_L_code_nosuperpg_data_superpg_rw_nosmt_usr_116_3/
#	#reboot -k kernel_all
#EOF
#sleep 180
#
#
#
#ssh root@10.79.20.116 <<EOF
#	sysctl vm.pmap.nxpg_ps_disabled=1
#	sysctl vm.fast_nxpg_ps_disabled=1
#	sysctl vm.pmap.xpg_ps_disabled=1
#	sysctl vm.fast_xpg_ps_disabled=1
#	cd /home/xd10/tests/mysql
#	cpuset -c -l 1,2 mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=160000 --time=6000 run
#	mysql-server onestop
#	cpuset -c -l 1,2 mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=1600000 --time=6000 run
#	cpuset -c -l 3 ./run_top.sh M_L_nosuperpg_rw_nosmt $1 $2 agg-data-superpg
#	#mv results/out.txt results/mysql_ld_$1_1600000t_ro_4thrd_M_L_nosuperpg_rw_nosmt_usr_116_3/
#	#reboot -k agg-data-superpg
#EOF
#sleep 180
#
#
#
#
##ssh root@10.79.20.116 <<EOF
##	cd /home/xd10/tests/mysql
##	cpuset -c -l 1,2 mysql-server onestart
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=80000 --time=6000 run
##	mysql-server onestop
##	cpuset -c -l 1,2 mysql-server onestart
##	sysctl vm.pmap.pde.mappings > baseline_before 2>&1 
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=800000 --time=6000 run
##	time -o time.txt ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=800000 --time=6000 run
##	sysctl vm.pmap.pde.mappings > baseline_after 2>&1 
##	cpuset -c -l 3 ./run.sh M_L >& results/out.txt
##	mv results/out.txt results/mysql_ld_$1_1600000t_ro_4thrd_M_L_rw_usr_116_3/
##	reboot -k kernel_all
##EOF
##sleep 180
#
##ssh root@10.79.20.116 <<EOF
##	sysctl vm.pmap.nxpg_ps_disabled=1
##	cd /home/xd10/tests/mysql
##	cpuset -c -l 1,2 mysql-server onestart
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=80000 --time=6000 run
##	mysql-server onestop
##	cpuset -c -l 1,2 mysql-server onestart
##	sysctl vm.pmap.pde.mappings > data_nosuperpg_before 2>&1 
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=800000 --time=6000 run
##	sysctl vm.pmap.pde.mappings > data_nosuperpg_after 2>&1 
##	cpuset -c -l 3 ./run.sh M_L_data_nosuperpg >& results/out.txt
##	mv results/out.txt results/mysql_ld_$1_1600000t_ro_4thrd_M_L_data_nosuperpg_rw_usr_116_3/
##	reboot -k agg-data-superpg
##EOF
##sleep 180
##
##
##
##ssh root@10.79.20.116 <<EOF
##	kldload /home/xd10/hwpmc.ko
##        sysctl vm.reserv.wakeup_frequency=1
##        sysctl vm.reserv.wakeup_time=20
##        sysctl vm.reserv.pop_budget=200
##        sysctl vm.reserv.pop_threshold=0
##        sysctl vm.reserv.enable_prezero=1
##	cd /home/xd10/tests/mysql
##	cpuset -c -l 1,2 mysql-server onestart
##	sysctl vm.reserv.pop_succ > record_before.txt 2>&1
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=80000 --time=6000 run
##	sysctl vm.reserv.pop_succ > record_one_round.txt 2>&1
##	mysql-server onestop
##	cpuset -c -l 1,2 mysql-server onestart
##	sysctl vm.pmap.pde.mappings > data_superpg_before 2>&1 
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=800000 --time=6000 run
##	sysctl vm.pmap.pde.mappings > data_superpg_after 2>&1 
##	cpuset -c -l 3 ./run.sh M_L_data_superpg >& results/out.txt
##	mv results/out.txt results/mysql_ld_$1_1600000t_ro_4thrd_M_L_data_superpg_rw_usr_116_3/
##	reboot -k kernel_all
##EOF
##sleep 180
#
#
##ssh root@10.79.20.116 <<EOF
##	cd /home/xd10/tests/mysql
##	cpuset -c -l 1,2 mysql-server onestart
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=80000 --time=6000 run
##	dd if=/usr/local/libexec/mysqld of=/dev/null
##	mysql-server onestop
##	cpuset -c -l 1,2 mysql-server onestart
##	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --threads=800000 --time=6000 run
##	cpuset -c -l 3 ./run.sh Ms_L >& results/out.txt
##	mv results/out.txt results/mysql_ld_$1_1600000t_ro_4thrd_Ms_L_rw_usr_116_3/
##	reboot -k agg-data-superpg
##EOF
##sleep 180
#
#ssh root@10.79.20.116 << EOF
#	reboot -k agg-data-superpg
#EOF
#sleep 180 
#
#
#
#ssh root@10.79.20.116 <<EOF
#	kldload /home/xd10/hwpmc.ko
#	sysctl vm.reserv.wakeup_frequency=1
#	sysctl vm.reserv.wakeup_time=20
#	sysctl vm.reserv.pop_budget=200
#	sysctl vm.reserv.pop_threshold=0
#	sysctl vm.reserv.enable_prezero=1
#	sysctl vm.fast_nxpg_ps_disabled=0
#	cd /home/xd10/tests/mysql
#	cpuset -c -l 1,2 mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=160000 --time=6000 run
#	dd if=/usr/local/libexec/mysqld of=/dev/null
#	mysql-server onestop
#	cpuset -c -l 1,2 mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=1600000 --time=6000 run 
#	cpuset -c -l 3 ./run_top.sh Ms_L_data_superpg_rw_nosmt $1 $2 kernel_all
#	#mv results/out*.txt results/mysql_ld_$1_1600000t_ro_4thrd_Ms_L_data_superpg_rw_nosmt_usr_116_3/
#	#reboot -k kernel_all
#EOF
#sleep 180

ssh root@10.79.20.116 << EOF
	reboot -k kernel_all
EOF
sleep 180 



ssh root@10.79.20.116 <<EOF
	sysctl vm.pmap.nxpg_ps_disabled=1
	sysctl vm.fast_nxpg_ps_disabled=1
	cd /home/xd10/tests/mysql
	cpuset -c -l 1,2 mysql-server onestart
	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=160000 --time=6000 run 
	dd if=/usr/local/libexec/mysqld of=/dev/null
	mysql-server onestop
	cpuset -c -l 1,2 mysql-server onestart
	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_write.lua --threads=7 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=$2 --events=1600000 --time=6000 run 
	cpuset -c -l 3 ./run_top.sh Ms_L_data_nosuperpg_rw_nosmt $1 $2 kernel
	#mv results/out*.txt results/mysql_ld_$1_1600000t_ro_4thrd_Ms_L_data_nosuperpg_rw_nosmt_usr_116_3/
EOF
sleep 180



