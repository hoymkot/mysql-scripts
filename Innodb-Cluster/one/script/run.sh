docker run --name=one \
   --mount type=bind,src=/docker/one/script/my.cnf,dst=/etc/my.cnf \
   --mount type=bind,src=/docker/one/data,dst=/var/lib/mysql \
   --network mysql \
   -e MYSQL_ROOT_PASSWORD=root \
   -d mysql/mysql-server:latest


