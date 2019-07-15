#!/usr/local/bin/bash -x

ssh root@10.79.20.116 << EOF
        reboot
EOF
sleep 180


ssh root@10.79.20.116 << EOF
        sysctl vm.code_promo_thld=$1
	cd /home/xd10/tests/java
	echo "before running warmup"
        cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -XX:CodeCacheExpansionSize=2m -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 500 -Dspecjvm.hardware.threads.override=4 derby
        echo "before running the test"
	cpuset -c -l 7 ./run_derby.sh L_J_thld$1 >& results/out.txt
        mv results/out.txt results/java_ld_derby_500ops_L_J_thld$1_usr_2/
	reboot
EOF
sleep 180

ssh root@10.79.20.116 << EOF
        sysctl vm.code_promo_thld=$1
	cd /home/xd10/tests/java
	echo "before running warmup"
        cpuset -c -l 2,3,4,5 java -XX:+AlwaysPreTouch -XX:CodeCacheExpansionSize=2m -jar SPECjvm2008.jar -ikv -ict -wt 0 -crf false -ops 500 -Dspecjvm.hardware.threads.override=4 compiler.compiler
        echo "before running the test"
        cpuset -c -l 7 ./run_compiler.sh L_J_thld$1 >& results/out.txt
        mv results/out.txt results/java_ld_compiler_500ops_L_J_thld$1_usr_2/
	reboot
EOF
sleep 180
