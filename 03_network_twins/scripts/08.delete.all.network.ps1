docker network inspect alpha --format '{{range .Containers}}{{.Name}}{{end}}' | ForEach-Object { docker network disconnect -f alpha $_ }

docker network inspect bravo --format '{{range .Containers}}{{.Name}}{{end}}' | ForEach-Object { docker network disconnect -f bravo $_ }

docker network rm alpha
docker network rm bravo
