param (
    [string]$action
)

$containerNames = @('c1.dry', 'c2.dry', 'c3.dry')

if ($action -eq "1") {
    # Iniciar los contenedores
    foreach ($containerName in $containerNames) {
        Write-Host "Starting container: $containerName"
        docker start $containerName
    }
}
elseif ($action -eq "0") {
    # Detener los contenedores
    foreach ($containerName in $containerNames) {
        Write-Host "Stopping container: $containerName"
        docker stop $containerName
    }
}
else {
    Write-Host "Invalid action. Use '1' to start or '0' to stop."
}
