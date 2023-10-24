$ErrorActionPreference = 'Stop' # Detiene el script en el primer error.

# Ruta del archivo con la versión actual.
$versionFile = "currentVersion"
$version = "1.0.0" # Valor predeterminado para la primera ejecución

# Verifica si el archivo de versión existe y lee el valor.
if (Test-Path -Path $versionFile) {
    $version = Get-Content $versionFile
}

# Descomponer la versión en números, incrementar la versión menor, y luego reconstruir la cadena de versión.
$versionParts = $version -split '\.'
$versionParts[2] = [string]([int]$versionParts[2] + 1)
$newVersion = $versionParts -join '.'

try {
    Write-Host "Versión nueva es $newVersion. Construyendo la imagen Docker..."
    # Construye la imagen con la nueva etiqueta de versión.
    $buildResult = docker build -f DockerfileFlutter -t "cinisarboris/imagen_flutter:$newVersion" .
    
    if ($LASTEXITCODE -ne 0) {
        throw "Docker build failed with exit code: $LASTEXITCODE"
    }

    Write-Host "Empujando la nueva imagen a Docker Hub..."
    # Sube la imagen construida a Docker Hub.
    docker push "cinisarboris/imagen_flutter:$newVersion"

    # Etiquetar la nueva imagen como "latest".
    docker tag "cinisarboris/imagen_flutter:$newVersion" "cinisarboris/imagen_flutter:latest"

    # Empujar la etiqueta "latest" a Docker Hub.
    docker push "cinisarboris/imagen_flutter:latest"

    # Si todo ha ido bien hasta este punto, actualizamos el archivo de versión.
    Set-Content -Path $versionFile -Value $newVersion

    # Limpieza: elimina el contenedor si ya existe.
    Write-Host "Verificando si el contenedor existe y eliminándolo..."
    docker rm -f flutter_container 2> $null

    Write-Host "Ejecutando el contenedor Docker en segundo plano..."
    # Correr el contenedor basado en la nueva imagen.
    docker run --name flutter_container --rm -d "cinisarboris/imagen_flutter:$newVersion" /bin/bash -c "while :; do sleep 10; done"
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
