#! /usr/local/bin/bash

TRIALS_PER_ITER=1 #5000

TRIAL=0
while [ $TRIAL -lt $TRIALS_PER_ITER ]; do
	clang -Wno-everything -O2 -c -DTIMES -DHZ=60 dhry_1.c dhry_2.c
	let TRIAL+=1
done

