@echo off

:: Comprobar si la red red21 existe
docker network inspect red21 >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    :: Eliminar la red si existe
    docker network rm red21
)

:: Crear la red red21
docker network create red21
