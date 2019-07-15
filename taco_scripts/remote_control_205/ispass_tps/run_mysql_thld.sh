#!/usr/local/bin/bash -x

#sysctl vm.pmap.xpg_ps_disabled=2
#sysctl vm.code_promo_thld=21
#sysctl vm.pmap.nxpg_ps_disabled=1


#ssh root@10.79.20.116 << EOF
#	reboot -k kernel
#EOF
#sleep 180 

ssh root@10.79.20.116 <<EOF
	sysctl vm.code_promo_thld=$1
	cd /home/xd10/tests/mysql
	cpuset -c -l 2,3,4,5 mysql-server onestart
	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=5000000 --events=160000 --time=6000 run
	mysql-server onestop
	cpuset -c -l 2,3,4,5 mysql-server onestart
	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=5000000 --events=1600000 --time=6000 run
	cpuset -c -l 7 ./run_top.sh M_L_thld$1 1.2G 5000000 kernel
EOF
sleep 180







