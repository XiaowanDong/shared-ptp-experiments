#!/usr/local/bin/bash -x

cd src1/
clang -Wno-everything -O2 -c -DTIMES -DHZ=60 dhry_1.c dhry_2.c &
pid=$!
procstat -v $pid
wait $pid
