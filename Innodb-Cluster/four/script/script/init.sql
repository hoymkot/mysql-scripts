CREATE USER 'user'@'%' IDENTIFIED BY 'user';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';
GRANT GRANT OPTION ON *.* TO 'user'@'%';
FLUSH PRIVILEGES