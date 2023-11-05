@echo off
cls

set DOCKER_PATH=C:\Users\evargasm\Documents\git\docker_fragmente\DDE-V1E1-004\semana_3.laboratorio_4
set IMAGE_NAME=i.node
set CONTAINER_NAME=c.custom-proyect
set APP_PATH=/app
set LOCAL_CHALLENGE_PATH=%DOCKER_PATH%\qwerty\.

:: Verificar si la imagen ya existe
docker images --format "{{.Repository}}" | findstr /R "^%IMAGE_NAME%$" >nul

:: Si el comando anterior (findstr) no encuentra la imagen, el código de salida será 1
if errorlevel 1 (
    echo La imagen %IMAGE_NAME% no existe. Creando...
    :: Construir la imagen Docker
    docker build --tag=%IMAGE_NAME% "%DOCKER_PATH%"
)

:: Eliminar el contenedor si ya existe
docker rm -f %CONTAINER_NAME% 2>nul

:: Ejecutar el contenedor
docker run -p 1337:1337 -d --name=%CONTAINER_NAME% %IMAGE_NAME%

:: Crear el directorio en el contenedor
docker exec %CONTAINER_NAME% mkdir -p %APP_PATH%

:: Copiar el contenido (y solo el contenido) de challenge/ al contenedor
docker cp "%LOCAL_CHALLENGE_PATH%" %CONTAINER_NAME%:%APP_PATH%

docker exec %CONTAINER_NAME% npm cache clean -f
docker exec %CONTAINER_NAME% rm -rf %APP_PATH%/node_modules
docker exec %CONTAINER_NAME% rm %APP_PATH%/package-lock.json
docker exec %CONTAINER_NAME% npm install --verbose --prefix %APP_PATH%

:: Instalar dependencias
docker exec %CONTAINER_NAME% npm install


:: Exponer el puerto (aunque esto ya se hizo al ejecutar el contenedor, por lo que este comentario es solo aclaratorio)

:: Iniciar la aplicación node.js
:: NOTA: Este comando no retornará el control hasta que el proceso termine, así que si deseas que el script continúe, tendrías que ejecutar node en modo detached.
:: docker exec c.custom-proyect node /app/index.js
