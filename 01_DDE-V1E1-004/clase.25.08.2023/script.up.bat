@echo off

REM Configuración de directorios y nombres de archivo
set BASE_DIR=#
set COMPOSE_FRAGMENT=compose.mariadb.yml

set COMPOSE_FILE=%BASE_DIR%\%COMPOSE_FRAGMENT%

REM Parar y remover el contenedor
docker-compose -f "%COMPOSE_FILE%" down

REM Eliminar el directorio del volumen
rd /s /q "%APPDATA%\share\db960\"

REM Descargar la imagen de MariaDB y etiquetarla
docker pull mariadb:latest
docker tag mariadb:latest maria-custom

REM Usar docker-compose para subir los contenedores
docker-compose -f "%COMPOSE_FILE%" up -d

REM Comprobar que MariaDB esté listo para conexiones
for /L %%x in (1, 1, 30) do (
    docker exec cmaria960 bash -c "mariadb -uroot -p123456 -e \"exit\""
    if errorlevel 1 (
        echo Esperando que MariaDB esté listo para conexiones...
        timeout /t 10
    ) else (
        goto connected
    )
)

:connected
REM Conectar a MariaDB y establecer permisos
docker exec -it cmaria960 bash -c "mariadb -uroot -p123456 -e \"GRANT ALL PRIVILEGES ON dbbase.* TO 'dbuser'@'%' IDENTIFIED BY '123456'; FLUSH PRIVILEGES;\""

echo Todo listo.
