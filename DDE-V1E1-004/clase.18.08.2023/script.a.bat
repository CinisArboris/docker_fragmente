:: Personalizar una imagen docker base, para luego subir a dockerhub.

:: Descargar la imagen base
docker pull debian:bullseye

:: Nueva imagen con el tag: i.debian.18
docker tag debian:bullseye i.debian.18

:: Detener el contenedor si existe
docker stop c.debian.18 2>nul

:: Eliminar el contenedor si existe
docker rm c.debian.18 2>nul

:: Crear el contenedor
docker run -d --name c.debian.18 i.debian.18 tail -f /dev/null

:: Actualizar debian
docker exec c.debian.18 apt-get update

:: Instalar nmap
docker exec c.debian.18 apt-get install -y nmap
