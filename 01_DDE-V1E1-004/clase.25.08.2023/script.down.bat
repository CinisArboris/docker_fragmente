@echo off

set BASE_DIR=#
set COMPOSE_FRAGMENT=compose.mariadb.yml

set COMPOSE_FILE=%BASE_DIR%\%COMPOSE_FRAGMENT%

docker-compose -f "%COMPOSE_FILE%" down
