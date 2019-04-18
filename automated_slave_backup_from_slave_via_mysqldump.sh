#!bin/sh


show_slave_status() {
    echo -e "--- master.info: ---">> $LOG_FILE
    cat ${MAIN_PATH}/data/master.info | sed -n '2,3p' >> $LOG_FILE
    echo -e "--- show slave status: ---" >> $LOG_FILE
    echo "show slave status \G" | $MYSQL_CMD | egrep "Slave_IO_Runing|Slave_SQL_Runing|Master_LOG_FILE|Read_Master_Log_Pos|Exec_Master_Log_Pos|Relay_Log_File|Relay_Log_Pos" >> $LOG_FILE
    echo -e "" >> $LOG_FILE

}

source /data/mysqldata/scripts/mysql_env.ini

HOST_PORT=3307
MAIN_PATH=/data/mysqldata/${HOST_PORT}
DATA_PATH=/data/mysqldata/backup/mysql_full
DATA_FILE=${DATA_PATH}/dbfullbak_`date+%F`.tar.gz
LOG_FILE=${DATA_PATH}/dbfullbak_`date+%F`.log
MYSQL_PATH=/usr/local/mysql/bin/
MYSQL_CMD="${MYSQL_PATH}/mysql -u${MYSQL_USER} -p${MYSQL_PASS} -S ${MAIN_PATH}/mysql.sock" 
MYSQL_DUMP="${MAIN_PATH}/mysqldump -u${MYSQL_USER} -p${MYSQL_PASS} -S ${MAIN_PATH}/mysql.sock --single-transaction"

echo > $LOG_FILE;
echo -e " === Jobs started at `date +%F' '%T' '%w` ===\n" >> $LOG_FILE
echo -e "*** started position: ===" >> $LOG_FILE
echo "stop slave SQL_THREAD;" | $MYSQL_CMD
show slave_status

echo -e "*** Executed command: ${MYSQL_DUMP} | gzip > ${DATA_FILE} " >> $LOG_FILE
${MYSQL_DUMP} | gzip > ${DATA_FILE} 
echo -e "*** Executed finished at `date +%F' '%T' '%w` === " >> $LOG_FILE
echo -e "*** Backup file size: `du -sh ${DATA_FILE}` ===\n" >> $LOG_FILE

echo -e "*** recheck position ===" >> $LOG_FILE
show_slave_status
echo "start slave SQL_THREAD" | $MYSQL_CMD;

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

