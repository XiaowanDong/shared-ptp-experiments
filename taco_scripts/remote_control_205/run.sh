#!/usr/local/bin/bash -x

# run_postgres_4core_remote.sh: argument1 is the size of the database, argument2 is the number of clients
for i in 96 
do
	./run_postgres_4core_remote.sh 75 $i
done
