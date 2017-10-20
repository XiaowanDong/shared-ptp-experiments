#! /usr/local/bin/bash

TRIALS_PER_ITER=10000 #50000

TRIAL=0
while [ $TRIAL -lt $TRIALS_PER_ITER ]; do
	clang -c ./empty.c
	let TRIAL+=1
done

