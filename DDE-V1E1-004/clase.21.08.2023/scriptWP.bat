FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "ancestor=wordpress"') DO (
    docker stop %%i && docker rm %%i
)
FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "name=frontwp"') DO (
    docker stop %%i && docker rm %%i
)



FOR /F "tokens=*" %%i IN ('docker images -q wordpress') DO (
    docker rmi %%i
)



docker run -d ^
--name frontwp ^
--network redwp ^
-v "%APPDATA%\share\:/var/www/html/wp-content" ^
-e WORDPRESS_DB_HOST=dbmysql ^
-e WORDPRESS_DB_USER=wpuser ^
-e WORDPRESS_DB_PASSWORD=123456 ^
-e WORDPRESS_DB_NAME=wpbase ^
-p 8080:80 ^
wordpress
