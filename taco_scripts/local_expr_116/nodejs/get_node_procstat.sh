#!/usr/local/bin/bash -x

node index.js &
pid=$!
procstat -v $pid
wait $pid
