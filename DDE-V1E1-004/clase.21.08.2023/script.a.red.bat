@echo off

:: Comprobar si la red red21 existe
docker network inspect red21 >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo La red "red21" ya existe.

    :: Obtener contenedores conectados a la red y desconectarlos
    FOR /F "tokens=*" %%i IN ('docker network inspect red21 --format "{{range .Containers}}{{.Name}} {{end}}"') DO (
        FOR %%j IN (%%i) DO (
            echo Desconectando el contenedor %%j de la red "red21"...
            docker network disconnect red21 %%j
        )
    )

    echo Eliminando la red "red21"...
    :: Eliminar la red
    docker network rm red21
) ELSE (
    echo La red "red21" no existe.
)

:: Crear la red red21
echo Creando la red "red21"...
docker network create red21

echo Listo.
