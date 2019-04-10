#!/usr/bin/env bash

INTERVAL=5
PREFIX=$INTERVAL-sec-status
RUNFILE=/tmp/running
mysql -e "SHOW GLOBAL VARIABLES" >> mysql-variables
while test -e $RUNFILE; do
    file=$(date +%F_%I)
    sleep=$(date +%s.%N | awk "{print $INTERVAL - (\$1 % $INTERVAL)}")
    sleep $sleep
    ts="$(date +"TS %s.%N %F %T")"
    loadavg="$(uptime)"

    echo "${ts} ${loadavg}" >> ${PREFIX}-${file}-status
    mysql -e "SHOW GLOBAL STATUS" >> ${PREFIX}-${file}-status &

    echo "${ts} ${loadavg}" >> ${PREFIX}-${file}-innodbstatus
    mysql -e "SHOW ENGINE INNODB STATUS\G" >> ${PREFIX}-${file}-innodbstatus &

    echo "${ts} ${loadavg}" >> ${PREFIX}-${file}-processlist
    mysql -e "SHOW FULL PROCESSLIST\G" >> ${PREFIX}-${file}-processlist &

    echo $ts
done

echo Exiting because $RUNFILE does not exist.

# 133
mysqladmin ext -i1 | awk '
  /Threads_running/{printf "%5d %5d %5d\n", q, tc, $4}'
  /Queries/{q=$4-qp;qp=$4}
  /Threads_connexted/{tc=$4}


# 134
mysqladmin processlist | grep State: | sort | uniq -c | sort -rn

# 135 利用慢查询日志,每秒查询数量?
awk '/^# Time:/{print $3, $4, c;c=0}/^# User/{c++}' slow-query.log

# 获得某个状态线程的数量
mysql -e 'SHOW PROCESSLIST\G' | grep -c "State: freeing items"

