# Desconectar contenedores de la red bridge
docker network disconnect bridge D1_container 2>$null
docker network disconnect bridge D2_container 2>$null
docker network disconnect bridge D3_container 2>$null
docker network disconnect bridge D4_container 2>$null

# Eliminar y recrear la red alpha si ya existe
$alphaExists = docker network ls | Select-String "alpha"
if ($alphaExists) {
    docker network rm alpha
}
docker network create alpha

# Eliminar y recrear la red bravo si ya existe
$bravoExists = docker network ls | Select-String "bravo"
if ($bravoExists) {
    docker network rm bravo
}
docker network create bravo

# Conectar contenedores a las redes
docker network connect alpha D1_container
docker network connect alpha D2_container

docker network connect bravo D3_container
docker network connect bravo D4_container

# Inspeccionar las redes
docker network inspect alpha
docker network inspect bravo
