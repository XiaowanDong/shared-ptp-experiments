#!/usr/local/bin/bash -x

#for size in 77 320 640
for size in 320
do
	./run_postgres_single_connect_rw.sh $size
done
