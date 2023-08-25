:: Detener y eliminar contenedores basados en la imagen de mariadb
FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "ancestor=mariadb"') DO (
    docker stop %%i && docker rm %%i
)

:: Detener y eliminar contenedores con el nombre de mariadb
FOR /F "tokens=*" %%i IN ('docker ps -a -q --filter "name=mariadb"') DO (
    docker stop %%i && docker rm %%i
)

:: Eliminar imágenes de mariadb
FOR /F "tokens=*" %%i IN ('docker images -q mariadb') DO (
    docker rmi %%i
)

:: Eliminar carpeta compartida
rd /s /q "%APPDATA%\share\*"

:: Correr un nuevo contenedor de mariadb
docker run -d ^
--name mariadb ^
--network redwp ^
-v "%APPDATA%\share\:/var/lib/mysql" ^
-e MARIADB_DATABASE=pmadb ^
-e MARIADB_USER=pmauser ^
-e MARIADB_PASSWORD=123456 ^
-e MARIADB_ROOT_PASSWORD=123456 ^
mariadb
