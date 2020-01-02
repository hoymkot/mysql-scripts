CHANGE MASTER TO MASTER_USER='rpl_user', MASTER_PASSWORD='password' FOR CHANNEL 'group_replication_recovery';
set Global group_replication_recovery_get_public_key=1;
START GROUP_REPLICATION;

SET PERSIST group_replication_consistency='BEFORE_ON_PRIMARY_FAILOVER';
