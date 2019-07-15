#!/usr/local/bin/bash -x

#ssh root@10.79.20.116 << EOF
#	mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=42700000 cleanup
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=5000000 prepare
#	mysql-server onestop
#EOF
#./run_mysql_single.sh 1.2G 5000000

ssh root@10.79.20.116 << EOF
	mysql-server onestart
	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=213000000 cleanup
	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=21300000 prepare
	mysql-server onestop
EOF
./run_mysql_single_rw_nosmt.sh 5G 21300000

#ssh root@10.79.20.116 << EOF
#	mysql-server onestart
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=21300000 cleanup
#	ssh -n yz70@virt02-rca.cs.rice.edu sysbench /usr/ports/benchmarks/sysbench/work/sysbench-1.0.12/src/lua/oltp_read_only.lua --threads=14 --mysql-host=10.79.20.116 --mysql-user=root --mysql-port=3306 --mysql-password=password --tables=1 --table-size=42700000 prepare
#	mysql-server onestop
#EOF
#./run_mysql_single.sh 10G 42700000


