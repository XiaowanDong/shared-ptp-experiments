#!/usr/local/bin/bash
dropdb pgbench$1s
createdb pgbench$1s
pgbench -i -s $1 pgbench$1s
