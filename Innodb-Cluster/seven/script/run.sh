docker run --name=$1 \
   --mount type=bind,src=/docker/$1/data,dst=/var/lib/mysql \
   --network mysql \
   -e MYSQL_ROOT_PASSWORD=root \
   -d mysql/mysql-server:latest


