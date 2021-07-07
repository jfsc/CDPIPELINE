#!/usr/bin/env bash

docker-compose up -d

echo
docker ps -a --format "{{.ID}}" | while read -r line ; do
        echo $line $(docker inspect --format "{{ .Name }} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" \
        $line | sed 's/\///'):$(docker port "$line" | grep -o "0.0.0.0:.*" | cut -f2 -d:)
done
