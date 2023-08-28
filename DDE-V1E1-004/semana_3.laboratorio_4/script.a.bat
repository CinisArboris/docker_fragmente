@echo off
SET DOCKER_PATH=C:\Users\eyver\Documents\git\docker_fragmente\DDE-V1E1-004\semana_3.laboratorio_4

docker rm -f web_easterbunny
docker build --tag=web_easterbunny "%DOCKER_PATH%"
docker run -p 600:80 -it --name=web_easterbunny web_easterbunny
