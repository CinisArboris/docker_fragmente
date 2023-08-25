docker network ls | findstr /I "redwp"



IF %ERRORLEVEL% EQU 0 (
    docker network rm redwp
)



docker network create redwp
