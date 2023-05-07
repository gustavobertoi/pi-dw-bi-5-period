docker volume create --driver local pi-dw-bi-5-period-mysql-volume
docker run -d -e MYSQL_ROOT_PASSWORD=$DATABASE_PASS -e MYSQL_DATABASE=$DATABASE_NAME -p 3306:3306 -v pi-dw-bi-5-period-mysql-volume:/var/lib/mysql mysql:5.7