# Verificar si el contenedor está en ejecución
$container = docker ps --filter "name=contenedor_fabiola" --format "{{.ID}}"

if ($container) {
    Write-Host "El contenedor 'contenedor_fabiola' está en ejecución.`n"
    
    # Obtener y formatear las estadísticas del contenedor
    $stats = docker stats $container --no-stream --format "table {{.Container}}\t{{.Name}}\t{{.MemUsage}}\t{{.CPUPerc}}"
    
    # Mostrar las estadísticas en una tabla
    $stats | Format-Table -AutoSize

    # Verificar las limitaciones de CPU y memoria
    $inspect = docker inspect $container | ConvertFrom-Json
    $cpuQuota = $inspect[0].HostConfig.CpuQuota
    $cpuPeriod = $inspect[0].HostConfig.CpuPeriod
    $memoryLimit = $inspect[0].HostConfig.Memory

    Write-Host "`nConfiguraciones del contenedor:"
    Write-Host ("CPU Quota: " + $cpuQuota + " (debería ser 5000 para 5%)")
    Write-Host ("CPU Period: " + $cpuPeriod + " (normalmente 100000)")
    Write-Host ("Límite de Memoria: " + ($memoryLimit / 1MB) + "MB (debería ser 100MB)")

    if ($cpuQuota -eq 5000 -and $cpuPeriod -eq 100000 -and $memoryLimit -eq 104857600) {
        Write-Host "`nLas restricciones de recursos están correctamente configuradas."
    } else {
        Write-Host "`nLas restricciones de recursos NO están correctamente configuradas."
    }
} else {
    Write-Host "El contenedor 'contenedor_fabiola' no se está ejecutando."
}
