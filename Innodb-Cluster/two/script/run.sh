docker stop two
docker rm two
docker run --name=two \
   --mount type=bind,src=/docker/two/script/my.cnf,dst=/etc/my.cnf \
   --mount type=bind,src=/docker/two/data,dst=/var/lib/mysql \
   --network mysql \
   -e MYSQL_ROOT_PASSWORD=root \
   -d mysql/mysql-server:latest


