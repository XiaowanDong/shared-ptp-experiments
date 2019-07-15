#!/usr/local/bin/bash -x

./run.sh $1 $2 $3 >& results/out.txt
mv results/out.txt results/mysql_ld_$2_1600000t_ro_4thrd_$1_usr_116_3/
reboot -k $4
