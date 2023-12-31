:: Obtener la imagen base (debian)
docker pull debian:bullseye

:: Asignar un tag a la imagen
docker tag debian:bullseye i.lab1

:: Crear el contenedor
docker run -d --name c.lab1 -p 100:80 i.lab1 tail -f /dev/null

:: Ingresar al contenedor
docker exec -it c.lab1 bash

:: Actualizar la biblioteca de librerias
apt-get update

:: Instalar el servidor
apt -y install apache2

:: Salir del contenedor
exit

:: Iniciar los servicios
docker exec c.lab1 service apache2 start

:: Modificando el index.html
echo ^<h1 style="text-align:center;"^>Nombre: Eyver Emilio Vargas Medina^</h1^> > index.html
docker cp index.html c.lab1:/var/www/html/index.html
del index.html
