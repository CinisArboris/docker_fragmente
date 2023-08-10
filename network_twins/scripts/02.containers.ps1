param (
    [string]$action
)

function Reset-Container {
    param (
        [string]$containerName,
        [string]$imageName
    )

    # Verifica si el contenedor ya existe
    $containerExists = docker ps -a -q -f name=$containerName
    if (-not [string]::IsNullOrEmpty($containerExists)) {
        # Detiene y borra el contenedor
        docker rm -f $containerName
    }

    # Crea el contenedor
    docker create --name $containerName $imageName
}

if ($action -eq "1") {
    # Llama a la función para crear cada contenedor
    Reset-Container -containerName 'c1' -imageName "d1_image"
    Reset-Container -containerName 'c2' -imageName "d2_image"
    Reset-Container -containerName 'c3' -imageName "d3_image"
    Reset-Container -containerName 'c4' -imageName "d4_image"
}
elseif ($action -eq "0") {
    # Borra los contenedores
    Write-Host "Deleting containers..."
    docker rm -f 'c1' 'c2' 'c3' 'c4'
}
else {
    Write-Host "Invalid action. Use '1' to create or '0' to delete."
}
