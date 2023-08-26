@echo off

SET DOCKER_DIR=C:\Users\eyver\Documents\git\docker_fragmente\DDE-V1E1-004\clase.21.08.2023
SET DOCKERFILE_NAME=Dockerfile.a
SET CONTAINER_NAME=dbmysql
SET VOLUME_PATH=%APPDATA%\share\

:: Construir la imagen usando el Dockerfile especificado
docker build -t mysql-custom -f %DOCKER_DIR%\%DOCKERFILE_NAME% %DOCKER_DIR%

:: Detener el contenedor si existe
docker stop %CONTAINER_NAME% 2>nul

:: Eliminar el contenedor si existe
docker rm %CONTAINER_NAME% 2>nul

:: Ejecutar un nuevo contenedor
docker run -d ^
--name %CONTAINER_NAME% ^
--network red21 ^
-v "%VOLUME_PATH%:/var/lib/mysql" ^
-e MYSQL_DATABASE=wpbase ^
-e MYSQL_USER=wpuser ^
-e MYSQL_PASSWORD=123456 ^
-e MYSQL_ROOT_PASSWORD=123456 ^
mysql-custom
