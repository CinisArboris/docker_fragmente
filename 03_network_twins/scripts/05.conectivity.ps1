function Test-PingConnectivity {
    param (
        [string]$sourceContainer,
        [string]$sourceIP,
        [string]$targetIP
    )

    $pingResult = docker exec $sourceContainer ping -c 1 -w 2 $targetIP

    if ($LASTEXITCODE -eq 0) {
        Write-Output "$sourceIP can reach IP $targetIP"
    } else {
        Write-Output "$sourceIP cannot reach IP $targetIP"
    }
}

$containerMappings = @{
    "c1" = "172.17.0.2"
    "c2" = "172.17.0.3"
    "c3" = "172.17.0.4"
    "c4" = "172.17.0.5"
}

# Test connectivity between specific containers
Test-PingConnectivity -sourceContainer "c1" -sourceIP $containerMappings["c1"] -targetIP $containerMappings["c3"]
Test-PingConnectivity -sourceContainer "c2" -sourceIP $containerMappings["c2"] -targetIP $containerMappings["c4"]
