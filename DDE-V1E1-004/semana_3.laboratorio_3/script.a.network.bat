docker network ls | findstr /I "r.lab3"

IF %ERRORLEVEL% EQU 0 (
    docker network rm r.lab3
)

docker network create r.lab3
