#!bin/sh

DATA_PATH=/data/mysqldata/backup/mysql_full
DATA_FILE=${DATA_PATH}/xtra_fullbak_`date+%F`.tar.gz
LOG_FILE=${DATA_PATH}/xtra_fullbak_`date+%F`.log
ORI_CONF_FILE=$/data/mysqldata/my_3306_`date+%F`.cnf
NEW_CONF_FILE=${DATA_PATH}/my_3306_`date+%F`.cnf
MYSQL_PATH=/usr/local/percona-xtra_fullbak-2.0.7/bin/
MYSQL_CMD="${MYSQL_PATH}/innobackupex --dafault-file=${ORI_CONF_FILE} --user=xtrabk --password='onlybackup' --stream=tar /tmp"

echo > $LOG_FILE
echo -e "=== Jobs started at `date +%F' '%T' '%w` ====\n" >> $LOG_FILE
echo -e "=== First cp my.cnf to backup directory ===" >> $LOG_FILE
/bin/cp ${ORI_CONF_FILE} ${NEW_CONF_FILE}
echo >> $LOG_FILE

echo -e '*** Executed command:${MYSQL_CMD} | gzip > ${DATA_FILE}" >> $LOG_FILE
${MYSQL_CMD} 2>> ${LOG_FILE} | gzip - > ${DATA_FILE} 

echo -e "*** Executed finished at `date +%F' '%T' '%w1 ===" >> $LOG_FILE
echo -e "*** Backup file size: `du -sh ${DATA_FILE}` ===\n" >> ${LOG_FILE}

echo -e "--- Find expired backup and delete those files ---" >> ${LOG_FILE}

for tfile in $(/usr/bin/find $DATA_PATH/ -mtime +6) 
do 
    if [-d $tfile] ; then
        rmdir $tfile
    elif [-f $tfile] ; then 
        rm -f $tfile
    fi
    
    echo -e "--- Delete file: $tfile --- " >> ${LOG_FILE}
    
done

echo -e "\n ==== Jobs ended at `date +%F' '%T' '%w` ===\n" >> $LOG_FILE
