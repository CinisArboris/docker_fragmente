param (
    [string]$action
)

if ($action -eq "1") {
    # Reconstruir las imágenes
    docker build -t 'i1.dry' -f '../imagen/Baldur1' '../imagen/Baldur1'
    docker build -t 'i2.dry' -f '../imagen/Baldur2' '../imagen/Baldur2'
    docker build -t 'i3.dry' -f '../imagen/Baldur3' '../imagen/Baldur3'
}
elseif ($action -eq "0") {
    # Eliminar las imágenes
    docker rmi -f 'i1.dry' 'i2.dry' 'i3.dry'
}
else {
    Write-Host "Invalid action. Use '1' to create or '0' to delete."
}
