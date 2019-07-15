#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        sysctl vm.code_promo_thld=$1
        cd /home/xd10/tests/nodejs/node_modules/react-ssr-benchmarks
        cpuset -c -l 2,3,4,5 node index.js >& /dev/null
        cpuset -c -l 7 ./run.sh M_L_thld$1 >& /home/xd10/tests/nodejs/results/out.txt
        mv /home/xd10/tests/nodejs/results/out.txt /home/xd10/tests/nodejs/results/node_reactssr_ld_1500iter_6thrd_M_L_thld$1_116_usr_1/
        reboot
EOF
sleep 180
