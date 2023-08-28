@echo off
SET DOCKER_PATH=#

docker rm -f c.custom-proyect

docker build --tag=i.node "%DOCKER_PATH%"

docker run -p 600:80 -it --name=c.custom-proyect i.node
