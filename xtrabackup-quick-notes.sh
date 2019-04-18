Xtradbbackup - online backup
 
create user xtrabk@localhost identified by 'onlybackup';
grant reload, lock tables, Replication client, super on *.* to 'xtrabk'@'localhost';
 
Full Backup
innobackupex --user=xtrabk --password=onlybackup inno
Full Backup compressed
innobackupex --user=xtrabk --password=onlybackup --stream=tar /tmp | gzip -> inno-zip

 
Incremental Backup
innobackupex --user=xtrabk --password=onlybackup --incremental --incremental-basedir=inno/2019-04-18_08-59-37 incre
 
Recovery Stop MySQL
 sudo -u mysql innobackupex --copy-back inno/2019-04-18_08-59-37
 
Recovery Preparation and ready for incremental  
innobackupex  --apply-log --redo-only inno/2019-04-18_08-59-37
Create a new log sequence number ( a new log file) no need if incremental is waiting for the next step 
innobackupex  --apply-log --redo-only inno/2019-04-18_08-59-37 

Recover Incremental
innobackupex --apply-log inno/2019-04-18_08-59-37 --incremental-dir=incre/2019-04-18_12-28-44/
innobackupex --apply-log inno/2019-04-18_08-59-37 --incremental-dir=incre/2019-04-18_12-28-44/

Copy Back
sudo innobackupex --copy-back inno/2019-04-18_08-59-37

Copy Back my.cnf the MySQL configuration file

change ownership
sudo chown mysql:mysql -R /var/lib/mysql/*

Get MYSQLD Servie online
sudo service mysql start
