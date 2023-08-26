docker-compose -f compose.mariadb.yml up -d

docker exec c.mariadb apt-get update -y
docker exec c.mariadb apt-get install mysql-client -y
