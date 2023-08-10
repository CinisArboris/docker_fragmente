param (
    [string]$action
)

if ($action -eq "1") {
    # Reconstruir las imágenes
    docker build -t 'd1_image' -f "../images/Baldur1" ../images/Baldur1
    docker build -t 'd2_image' -f "../images/Baldur2" ../images/Baldur2
    docker build -t 'd3_image' -f "../images/Baldur3" ../images/Baldur3
    docker build -t 'd4_image' -f "../images/Baldur4" ../images/Baldur4
}
elseif ($action -eq "0") {
    # Eliminar las imágenes
    docker rmi -f 'd1_image' 'd2_image' 'd3_image' 'd4_image'
}
else {
    Write-Host "Invalid action. Use '1' to create or '0' to delete."
}
