#!/bin/sh

cpuset -c -l 4,5 /usr/local/etc/rc.d/postgresql restart
pgbench -i -s 300 pgbench #16GB database: scale/75 = 1GB
pgbench -j 1 -c 2 -t 4000000 -S pgbench
