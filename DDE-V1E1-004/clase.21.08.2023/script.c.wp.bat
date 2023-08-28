@echo off

SET DOCKER_DIR=#
SET DOCKERFILE_NAME=DockerfileWP
SET CONTAINER_NAME=frontwp900
SET VOLUME_PATH=%APPDATA%\share\web900\

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
-e WORDPRESS_DB_HOST=dbmysql960 ^
-e WORDPRESS_DB_NAME=dbbase ^
-e WORDPRESS_DB_USER=dbuser ^
-e WORDPRESS_DB_PASSWORD=123456 ^
-p 900:80 ^
wordpress-custom
