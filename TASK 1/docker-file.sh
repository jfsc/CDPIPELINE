#!/usr/bin/env bash

time \
(echo "=> Create application network"
docker network create task1 \

docker build --build-arg url=https://github.com/romuloslv/spring-petclinic.git \
             --build-arg project=spring-petclinic \
             --build-arg artifactid=spring-petclinic \
             --build-arg version=2.2.0 \
             -t img-petclinic - < Dockerfile

echo "=> Build database image"
docker run --name mysql \
           --network task1 \
           -e MYSQL_ROOT_PASSWORD=petclinic \
           -e MYSQL_DATABASE=petclinic \
           -p 3306:3306 \
           -d mysql:5.7.8

echo "=> Build application image"
docker run --name petclinic \
           --network task1 \
           -p 8080:8080 \
           -d img-petclinic

echo "=> Removing <none> images"
docker rmi $(docker images -f "dangling=true" -q)
export DOCKERHUB_USERNAME=${1}

echo "=> Tagging petclinic"
docker tag img-petclinic $(echo $DOCKERHUB_USERNAME)/petclinic
echo "=> Tagged petclinic"

echo "=> Pushing petclinic"
docker push $(echo $DOCKERHUB_USERNAME)/petclinic
echo "=> Pushed petclinic"

echo
docker ps -a --format "{{.ID}}" | while read -r line ; do
	echo $line $(docker inspect --format "{{ .Name }} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" \
	$line | sed 's/\///'):$(docker port "$line" | grep -o "0.0.0.0:.*" | cut -f2 -d:)
done)
