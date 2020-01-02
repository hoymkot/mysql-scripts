CREATE USER rpl_user@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO rpl_user@'%';
GRANT CLONE_ADMIN ON *.* TO rpl_user@'%';
FLUSH PRIVILEGES;

CHANGE MASTER TO MASTER_USER='rpl_user', MASTER_PASSWORD='password' FOR CHANNEL 'group_replication_recovery';
set Global group_replication_recovery_get_public_key=1;

SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group=OFF;

SET PERSIST group_replication_consistency='BEFORE_ON_PRIMARY_FAILOVER';
