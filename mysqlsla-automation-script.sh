# This script send an email with a report on slow queries everyday.

LOG_FILEPATH= /data/mysqldata/logs
LOG_FILENAME=${LOG_FILEPATH}/slow-query.log.`date +%F`
LOG_ANALYZE=${LOG_FILEPATH}/slow-query-ana.log.`date +%F`
SLOWLOG_FILENAME=/data/mysqldata/3306/slow_query.log

#Do the job
/bin/cp -f ${SLOWLOG_FILENAME} $LOG_FILENAME
/bin/echo "" > ${SLOWLOG_FILENAME}
/usr/bin/mysqlsla -lt slow ${LOG_FILENAME} --top 100 -Ai 1000 > ${LOG_ANALYZE}
/bin/cat ${LOG_ANAYLZE} | mail -s "[`date +%F`] MySQL slow logs" example@gmail.com

#Delete slowlog history
/usr/bin/find ${LOG_FILEPATH}/ -mtime +7 -exec rm {} \;


