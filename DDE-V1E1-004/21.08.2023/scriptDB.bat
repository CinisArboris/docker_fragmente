FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "ancestor=dbmysql"') DO (
    docker stop %%i && docker rm %%i
)
FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "name=dbmysql"') DO (
    docker stop %%i && docker rm %%i
)



FOR /F "tokens=*" %%i IN ('docker images -q dbmysql') DO (
    docker rmi %%i
)



rd /s /q "%APPDATA%\share\*"



docker run -d ^
--name dbmysql ^
--network redwp ^
-v "%APPDATA%\share\:/var/lib/mysql" ^
-e MYSQL_DATABASE=wpbase ^
-e MYSQL_USER=wpuser ^
-e MYSQL_PASSWORD=123456 ^
-e MYSQL_ROOT_PASSWORD=123456 ^
mysql
