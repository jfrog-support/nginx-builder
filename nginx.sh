#!/bin/bash

##Build & run an nginx server with SSL on port 443##
#--------------------------------------------------#
#Using the generic SSL nginx conf available at
#https://www.jfrog.com/confluence/display/RTF/Docker+Repositories#DockerRepositories-1.SettingupNGINXasaReverseProxy

#Let's modify the IP address of the Artifactory upstream to your own IP address
IP=`ifconfig  | grep inet | grep -v inet6 | head -n3 | tail -n1 | awk '{print $2}'`
for file in "ssl.conf" "artifactory.jf.conf"
do
  sed -e "s/localhost/$IP/g" -i $file
done

#only relevant for docker-machine
#DOCKER_IP=$(docker-machine ip dev)
#sed -i "" "s/artifactory.jf/$DOCKER_IP/g" ~/.docker/machine/machines/dev/config.json

#Now that we have ssl.conf, let's build a Docker image from the base "nginx" image available on the hub.
docker build -t nginx_ssl .
#run it
docker run -d -p 8000:80 -p 443:443 nginx_ssl
