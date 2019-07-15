#!/usr/local/bin/bash -x

for size in 77 320 640
do
	./run_postgres_single_connect.sh $size
done
