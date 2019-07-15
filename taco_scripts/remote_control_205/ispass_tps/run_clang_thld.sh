#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        sysctl vm.code_promo_thld=$1
        cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh M_L_thld$1 >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_M_L_thld$1_116_usr_1/
        reboot
EOF
sleep 180
