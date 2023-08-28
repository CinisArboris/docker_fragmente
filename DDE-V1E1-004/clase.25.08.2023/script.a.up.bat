@echo off
set COMPOSE_FILE=#

docker pull mariadb:latest
docker tag mariadb:latest mariadb-custom

docker-compose -f "%COMPOSE_FILE%" up -d
