@echo off

:: Comprobar si la red r.lab3 existe
docker network ls | findstr /I "r.lab3" >nul
IF %ERRORLEVEL% EQU 0 (
    echo La red "r.lab3" ya existe.

    :: Obtener contenedores conectados a la red y desconectarlos
    FOR /F "tokens=*" %%i IN ('docker network inspect r.lab3 --format "{{range .Containers}}{{.Name}} {{end}}"') DO (
        FOR %%j IN (%%i) DO (
            echo Desconectando el contenedor %%j de la red "r.lab3"...
            docker network disconnect r.lab3 %%j
        )
    )

    echo Eliminando la red "r.lab3"...
    :: Eliminar la red
    docker network rm r.lab3
) ELSE (
    echo La red "r.lab3" no existe.
)

:: Crear la red r.lab3
echo Creando la red "r.lab3"...
docker network create r.lab3

echo Listo.
