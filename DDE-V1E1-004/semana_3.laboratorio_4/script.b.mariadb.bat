:: Detener el contenedor si existe
docker stop c.mariadb 2>nul

:: Eliminar el contenedor si existe
docker rm c.mariadb 2>nul

:: Descargar la imagen de mariadb si no está presente
docker pull mariadb

:: Taggear la imagen de mariadb como i.mariadb
docker tag mariadb i.mariadb 2>nul

:: Correr un nuevo contenedor de i.mariadb
docker run -d ^
--name c.mariadb ^
--network r.lab3 ^
-p 700:3306 ^
-v "%APPDATA%\share:/var/lib/mysql" ^
-e MARIADB_DATABASE=mariadb ^
-e MARIADB_USER=mariauser ^
-e MARIADB_PASSWORD=123456 ^
-e MARIADB_ROOT_PASSWORD=123456 ^
i.mariadb

:: Instalar el cliente mysql dentro del contenedor
docker exec c.mariadb apt-get update -y
docker exec c.mariadb apt-get install mysql-client -y

:: Liberar el usuario para que pueda conectarse desde cualquier host
echo GRANT ALL PRIVILEGES ON *.* TO 'mariauser'@'%' IDENTIFIED BY '123456'; FLUSH PRIVILEGES; | docker exec -i c.mariadb mysql -u root --password=123456
