@echo off

SET DOCKER_DIR=C:\Users\eyver\Documents\git\docker_fragmente\DDE-V1E1-004\clase.21.08.2023
SET DOCKERFILE_NAME=Dockerfile.a
SET CONTAINER_NAME=dbmysql950
SET VOLUME_PATH=%APPDATA%\share\db950\

:: Construir la imagen usando el Dockerfile especificado
docker build -t mysql-custom -f %DOCKER_DIR%\%DOCKERFILE_NAME% %DOCKER_DIR%

:: Detener el contenedor si existe
docker stop %CONTAINER_NAME% 2>nul

:: Eliminar el contenedor si existe
docker rm %CONTAINER_NAME% 2>nul

:: Eliminar el contenido de la carpeta compartida
echo Eliminando el contenido de la carpeta compartida...
for /D %%X in ("%VOLUME_PATH%\*") do rmdir /S /Q "%%X"
del /Q "%VOLUME_PATH%\*.*"

:: Ejecutar un nuevo contenedor
docker run -d ^
--name %CONTAINER_NAME% ^
--network red21 ^
-v "%VOLUME_PATH%:/var/lib/mysql" ^
-e MYSQL_DATABASE=dbbase ^
-e MYSQL_USER=dbuser ^
-e MYSQL_PASSWORD=123456 ^
-e MYSQL_ROOT_PASSWORD=123456 ^
-p 950:3306 ^
mysql-custom
