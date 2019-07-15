#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        reboot -k kernel_all
EOF
sleep 180


ssh root@10.79.20.116 << EOF
        sysctl vm.pmap.nxpg_ps_disabled=2
        sysctl vm.fast_nxpg_ps_disabled=1
        sysctl vm.pmap.xpg_ps_disabled=2
        sysctl vm.fast_xpg_ps_disabled=1
        cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh M_L_nosuperpg >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_M_L_nosuperpg_116_usr_1/
        reboot -k kernel_all
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        sysctl vm.pmap.nxpg_ps_disabled=2
        sysctl vm.fast_nxpg_ps_disabled=1
        cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
	dd if=/usr/bin/clang of=/dev/null
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh Ms_L_data_nosuperpg >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_Ms_L_data_nosuperpg_116_usr_1/
        reboot -k agg-data-superpg
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        kldload /home/xd10/hwpmc.ko
        sysctl vm.reserv.wakeup_frequency=1
        sysctl vm.reserv.wakeup_time=20
        sysctl vm.reserv.pop_budget=200
        sysctl vm.reserv.pop_threshold=0
        sysctl vm.reserv.enable_prezero=1
	sysctl vm.pmap.xpg_ps_disabled=2
        sysctl vm.fast_xpg_ps_disabled=1
        cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh M-s_L_data_superpg >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_M-s_L_data_superpg_116_usr_1/
        reboot -k agg-data-superpg
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        kldload /home/xd10/hwpmc.ko
        sysctl vm.reserv.wakeup_frequency=1
        sysctl vm.reserv.wakeup_time=20
        sysctl vm.reserv.pop_budget=200
        sysctl vm.reserv.pop_threshold=0
        sysctl vm.reserv.enable_prezero=1
	cd /home/xd10/tests/clang/src1
        cpuset -c -l 0,1 ./warm_dhrystone.sh
	dd if=/usr/bin/clang of=/dev/null
        cd /home/xd10/tests/clang
        cpuset -c -l 7 ./run.sh Ms_L_data_superpg >& results/out.txt
        mv results/out.txt results/clang_ld_dhrystone_5000iters_Ms_L_data_superpg_116_usr_1/
        reboot
EOF
sleep 180
