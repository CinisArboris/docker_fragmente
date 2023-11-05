$ErrorActionPreference = 'Stop'

$versionFile = "currentVersion"
$version = "1.0.0"

if (Test-Path -Path $versionFile) {
    $version = Get-Content $versionFile
}

$versionParts = $version -split '\.'
$versionParts[2] = [string]([int]$versionParts[2])
$newVersion = $versionParts -join '.'

# Limpieza: elimina el contenedor si ya existe, capturando y suprimiendo errores.
Write-Host "Verificando si el contenedor existe y eliminándolo..."
$existingContainer = docker ps -a -q -f name=flutter_container
if (-not [string]::IsNullOrEmpty($existingContainer)) {
    docker rm -f flutter_container | Out-Null
}

Write-Host "Ejecutando el contenedor Docker en segundo plano..."
# Correr el contenedor basado en la nueva imagen.
try {
    docker run --name flutter_container --rm -d "cinisarboris/imagen_flutter:$newVersion" /bin/bash -c "while :; do sleep 10; done"
} catch {
    Write-Host "Error al ejecutar el contenedor Docker: $_" -ForegroundColor Red
    exit 1
}
