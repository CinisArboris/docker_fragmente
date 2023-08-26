:: Personalizar una imagen docker base, para luego subir a dockerhub.

:: Descargar la imagen base
docker pull debian:bullseye

:: Nueva imagen con el tag: default.imagen.debian.bullseye
docker tag debian:bullseye default.imagen.debian.bullseye

:: Detener el contenedor si existe
docker stop contenedor.bullseye 2>nul

:: Eliminar el contenedor si existe
docker rm contenedor.bullseye 2>nul

:: Crear el contenedor
docker run -d --name contenedor.bullseye default.imagen.debian.bullseye tail -f /dev/null

:: Actualizar debian
docker exec contenedor.bullseye apt-get update

:: Instalar nmap
docker exec contenedor.bullseye apt-get install -y nmap
