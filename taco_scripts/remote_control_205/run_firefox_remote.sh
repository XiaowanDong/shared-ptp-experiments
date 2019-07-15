#!/usr/local/bin/bash -x

ssh -Y root@10.79.20.116 << EOF
	cd /usr/home/xd10/tests/firefox
	./run.sh M_L
	reboot
EOF
sleep 180



ssh -Y root@10.79.20.116 << EOF
	cpuset -c -l 3,4 firefox
	dd if=/usr/local/lib/firefox/libxul.so of=/dev/null
	cd /usr/home/xd10/tests/firefox
	./run.sh Ms_L
	reboot
EOF
sleep 180


ssh -Y root@10.79.20.116 << EOF
	sysctl vm.pmap.xpg_ps_disabled=1
	cd /usr/home/xd10/tests/firefox
	./run.sh M-s_L
	reboot
EOF
sleep 180

ssh -Y root@10.79.20.116 << EOF
	sysctl vm.share_ptp=1
        sysctl vm.force_lib_align=1
        sysctl kern.elf32.share_main_ptp=1
        sysctl kern.elf64.share_main_ptp=1
        sysctl vm.share_lib_ptp=1
	cd /usr/home/xd10/tests/firefox
	./run.sh Mt_Lt
	reboot
EOF
sleep 180

	

ssh -Y root@10.79.20.116 << EOF
	cpuset -c -l 3,4 firefox
	dd if=/usr/local/lib/firefox/libxul.so of=/dev/null
	sysctl vm.share_ptp=1
        sysctl vm.force_lib_align=1
        sysctl kern.elf32.share_main_ptp=1
        sysctl kern.elf64.share_main_ptp=1
        sysctl vm.share_lib_ptp=1
	cd /usr/home/xd10/tests/firefox
	./run.sh Mst_Lt
	reboot
EOF
sleep 180






