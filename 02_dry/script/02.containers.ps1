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
    Reset-Container -containerName 'c1.dry' -imageName "i1.dry"
    Reset-Container -containerName 'c2.dry' -imageName "i2.dry"
    Reset-Container -containerName 'c3.dry' -imageName "i3.dry"
}
elseif ($action -eq "0") {
    # Borra los contenedores
    Write-Host "Deleting containers..."
    docker rm -f 'c1.dry' 'c2.dry' 'c3.dry'
}
else {
    Write-Host "Invalid action. Use '1' to create or '0' to delete."
}
