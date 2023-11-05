# Función para obtener y mostrar la IP de un contenedor
function Get-ContainerIP {
    param (
        [string]$containerName
    )

    $ip = docker inspect --format '{{ .NetworkSettings.IPAddress }}' $containerName
    Write-Output "$containerName IP: $ip"
}

$containerNames = @("c1", "c2", "c3", "c4")

foreach ($containerName in $containerNames) {
    Get-ContainerIP -containerName $containerName
}
