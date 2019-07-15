#!/usr/local/bin/bash -x

cpuset -c -l 1,2 java -XX:+AlwaysPreTouch -XX:CodeCacheExpansionSize=2m -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 80 -Dspecjvm.hardware.threads.override=6 derby &
pid=$!
sleep 20
procstat -v $pid
wait $pid
