docker stop three
docker rm three
docker run --name=three \
   --mount type=bind,src=/docker/three/script/my.cnf,dst=/etc/my.cnf \
   --mount type=bind,src=/docker/three/data,dst=/var/lib/mysql \
   --network mysql \
   -e MYSQL_ROOT_PASSWORD=root \
   -d mysql/mysql-server:latest


