# Construir la imagen con el Dockerfile
docker build -t fabiola_nginx -f DF_Fabiola .

# Detener y eliminar el contenedor existente si está en ejecución
docker stop contenedor_fabiola
docker rm contenedor_fabiola

# Ejecutar el contenedor con las restricciones de recursos
docker run -d --name contenedor_fabiola `
  --memory="100m" --memory-swap="100m" `
  --cpu-period=100000 --cpu-quota=5000 `
  -p 80:80 fabiola_nginx
