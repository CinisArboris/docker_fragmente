FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "ancestor=phpmyadmin"') DO (
    docker stop %%i && docker rm %%i
)
FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "name=frontpma"') DO (
    docker stop %%i && docker rm %%i
)



FOR /F "tokens=*" %%i IN ('docker images -q phpmyadmin') DO (
    docker rmi %%i
)



docker run -d ^
--name frontpma ^
-e PMA_HOST=dbmysql ^
-e PMA_USER=wpuser ^
-e PMA_PASSWORD=123456 ^
-p 8081:80 ^
phpmyadmin
