#!/usr/local/bin/bash -x

#for i in 5 14 17 31
for i in  5 14 17 31
do
	#./run_mysql_thld.sh $i
	./run_postgres_thld.sh $i
	#./run_nodejs_thld.sh $i
	#./run_clang_thld.sh $i
	./run_java_thld.sh $i
done
