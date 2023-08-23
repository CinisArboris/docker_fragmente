@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Detener el contenedor si existe
docker stop c.phpmyadmin 2>nul

:: Eliminar el contenedor si existe
docker rm c.phpmyadmin 2>nul

:: Descargar la imagen de phpmyadmin si no está presente
docker pull phpmyadmin

:: Taggear la imagen de phpmyadmin como i.phpmyadmin
docker tag phpmyadmin i.phpmyadmin 2>nul

:: Correr un nuevo contenedor de i.phpmyadmin
docker run -d ^
--name c.phpmyadmin ^
--network r.lab3 ^
-p 800:80 ^
-v "%APPDATA%\share:/var/lib/mysql" ^
-e PMA_HOST=c.mariadb ^
-e PMA_USER=mariauser ^
-e PMA_PASSWORD=123456 ^
i.phpmyadmin

ENDLOCAL
