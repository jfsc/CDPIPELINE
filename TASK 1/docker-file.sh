#!/bin/sh

time \
(docker network create springlab \
&& \
docker build --build-arg url=https://github.com/romuloslv/spring-petclinic.git \
             --build-arg project=spring-petclinic \
             --build-arg artifactid=spring-petclinic \
             --build-arg version=2.2.0 \
             -t img-petclinic - < Dockerfile \
&& \
docker run --name mysql \
           --network springlab \
           -e MYSQL_ROOT_PASSWORD=petclinic \
           -e MYSQL_DATABASE=petclinic \
           -p 3306:3306 \
           -d mysql:5.7.8 \
&& \
docker run --name petclinic \
           --network springlab \
           -p 8080:8080 \
           -d img-petclinic \
&& \
docker rmi $(docker images -f "dangling=true" -q) \
&& \
export DOCKERHUB_USERNAME="yourusername"

tag() {
    echo "=> Tagging petclinic"
    docker tag img-petclinic $(echo $DOCKERHUB_USERNAME)/petclinic
    echo "=> Tagged petclinic"
}

push() {
    echo "=> Pushing petclinic"
    docker push $(echo $DOCKERHUB_USERNAME)/petclinic
    echo "=> Pushed petclinic"
}

tag; push;
echo

exit 0)
