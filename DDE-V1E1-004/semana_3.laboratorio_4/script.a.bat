@echo off
SET DOCKER_PATH=C:\Users\evargasm\Documents\git\docker_fragmente\DDE-V1E1-004\semana_3.laboratorio_4

docker rm -f c.custom-proyect

docker build --tag=i.node "%DOCKER_PATH%"

docker run -p 600:80 -it --name=c.custom-proyect i.node
