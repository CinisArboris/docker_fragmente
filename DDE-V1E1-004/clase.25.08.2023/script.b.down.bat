@echo off
set COMPOSE_FILE=#

:: Detener y eliminar contenedores, redes y volúmenes definidos en el docker-compose
docker-compose -f "%COMPOSE_FILE%" down
