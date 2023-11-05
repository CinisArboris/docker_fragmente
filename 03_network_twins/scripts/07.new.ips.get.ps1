$D1_alpha_IP = docker inspect --format '{{ .NetworkSettings.Networks.alpha.IPAddress }}' 'c1'
$D2_alpha_IP = docker inspect --format '{{ .NetworkSettings.Networks.alpha.IPAddress }}' 'c2'
$D3_bravo_IP = docker inspect --format '{{ .NetworkSettings.Networks.bravo.IPAddress }}' 'c3'
$D4_bravo_IP = docker inspect --format '{{ .NetworkSettings.Networks.bravo.IPAddress }}' 'c4'

Write-Output "c1 in alpha network IP: $D1_alpha_IP"
Write-Output "c2 in alpha network IP: $D2_alpha_IP"
Write-Output "c3 in bravo network IP: $D3_bravo_IP"
Write-Output "c4 in bravo network IP: $D4_bravo_IP"
