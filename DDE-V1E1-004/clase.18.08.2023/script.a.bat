:: Definir variables
SET IMAGEN_BASE=debian:bullseye
SET NOMBRE_IMAGEN_PERSONALIZADA=debian-custom
SET VERSION_IMAGEN=v1.0.9
SET NOMBRE_CONTENEDOR=c.debian.18
SET NOMBRE_USUARIO_DOCKERHUB=cinisarboris
SET REPOSITORIO_DOCKERHUB=dde-v1e1-004

:: Descargar la imagen base
docker pull %IMAGEN_BASE%

:: Nueva imagen con el tag
docker tag %IMAGEN_BASE% %NOMBRE_USUARIO_DOCKERHUB%/%NOMBRE_IMAGEN_PERSONALIZADA%:%VERSION_IMAGEN%

:: Detener el contenedor si existe
docker stop %NOMBRE_CONTENEDOR% 2>nul

:: Eliminar el contenedor si existe
docker rm %NOMBRE_CONTENEDOR% 2>nul

:: Crear el contenedor
docker run -d --name %NOMBRE_CONTENEDOR% %NOMBRE_USUARIO_DOCKERHUB%/%NOMBRE_IMAGEN_PERSONALIZADA%:%VERSION_IMAGEN% tail -f /dev/null

:: Actualizar debian
docker exec %NOMBRE_CONTENEDOR% apt-get update

:: Instalar nmap
docker exec %NOMBRE_CONTENEDOR% apt-get install -y nmap

:: Hacer commit del contenedor a una nueva imagen
docker commit %NOMBRE_CONTENEDOR% %NOMBRE_USUARIO_DOCKERHUB%/%REPOSITORIO_DOCKERHUB%:%VERSION_IMAGEN%

:: Subir a Docker Hub
docker push %NOMBRE_USUARIO_DOCKERHUB%/%REPOSITORIO_DOCKERHUB%:%VERSION_IMAGEN%
