@echo off

:: Construye y arranca los servicios definidos en Compose.yml
echo Construyendo y arrancando servicios...
docker-compose -f Compose.yml up --scale web_easterbunny=3
