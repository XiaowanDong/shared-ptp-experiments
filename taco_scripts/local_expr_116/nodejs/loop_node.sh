#! /usr/local/bin/bash

TRIALS_PER_ITER=100

TRIAL=0
while [ $TRIAL -lt $TRIALS_PER_ITER ]; do
	node index.js >& /dev/null
	let TRIAL+=1
done
