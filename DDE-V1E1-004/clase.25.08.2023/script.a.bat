@echo off
set COMPOSE_FILE=C:\Users\eyver\Documents\git\docker_fragmente\DDE-V1E1-004\clase.25.08.2023\compose.mariadb.yml

docker pull mariadb:latest
docker tag mariadb:latest mariadb-custom

docker-compose -f "%COMPOSE_FILE%" up -d
