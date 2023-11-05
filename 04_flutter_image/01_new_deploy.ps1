$ErrorActionPreference = 'Stop'

$versionFile = "currentVersion"
$version = "1.0.0"

if (Test-Path -Path $versionFile) {
    $version = Get-Content $versionFile
}

$versionParts = $version -split '\.'
$versionParts[2] = [string]([int]$versionParts[2] + 1)
$newVersion = $versionParts -join '.'

try {
    Write-Host "Versión nueva es $newVersion. Construyendo la imagen Docker..."
    docker build -f DockerfileFlutter -t "cinisarboris/imagen_flutter:$newVersion" .
    if ($LASTEXITCODE -ne 0) {
        throw "Docker build failed with exit code: $LASTEXITCODE"
    }

    ## ===========================================================================================
    #Write-Host "Empujando la nueva imagen a Docker Hub..."
    ## Sube la imagen construida a Docker Hub.
    #docker push "cinisarboris/imagen_flutter:$newVersion"
    ## ===========================================================================================
    ## Etiquetar la nueva imagen como "latest".
    #docker tag "cinisarboris/imagen_flutter:$newVersion" "cinisarboris/imagen_flutter:latest"
    ## ===========================================================================================
    ## Empujar la etiqueta "latest" a Docker Hub.
    #docker push "cinisarboris/imagen_flutter:latest"
    ## ===========================================================================================
    ## Si todo ha ido bien hasta este punto, actualizamos el archivo de versión.
    #Set-Content -Path $versionFile -Value $newVersion
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}

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
