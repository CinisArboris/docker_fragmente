@echo off

SET DOCKER_DIR=C:\Users\eyver\Documents\git\docker_fragmente\DDE-V1E1-004\clase.21.08.2023
SET DOCKERFILE_NAME=Dockerfile.b
SET CONTAINER_NAME=frontwp
SET VOLUME_PATH=%APPDATA%\share\

:: Construir la imagen de WordPress (si tienes un Dockerfile)
docker build -t wordpress-custom -f %DOCKER_DIR%\%DOCKERFILE_NAME% %DOCKER_DIR%

:: Detener el contenedor frontwp si existe
docker stop %CONTAINER_NAME% 2>nul

:: Eliminar el contenedor frontwp si existe
docker rm %CONTAINER_NAME% 2>nul

:: Ejecutar un nuevo contenedor de WordPress
docker run -d ^
--name %CONTAINER_NAME% ^
--network red21 ^
-v "%VOLUME_PATH%:/var/www/html/wp-content" ^
-e WORDPRESS_DB_HOST=dbmysql ^
-e WORDPRESS_DB_USER=wpuser ^
-e WORDPRESS_DB_PASSWORD=123456 ^
-e WORDPRESS_DB_NAME=wpbase ^
-p 900:80 ^
wordpress-custom
