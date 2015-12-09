# nginx-builder
A repo for the nginx-builder scripts and Dockerfiles

## Setup ##

### Prerequirsites ###
-Docker CLI installed, runnable without 'sudo' (or modify nginx.sh to use sudo for docker commands) 

### Build and Run the image ###
1.Clone this repo to your host
`git clone https://github.com/jfrog-support/nginx-builder.git`

2.The nginx.sh shell script will try to figure out your host IP and modify the upstream server address to be your host IP in the ssl.conf file, however you may need to modify this section to make it work with your own system:
```bash
#Let's modify the IP address of the Artifactory upstream to your own IP address
IP=`ifconfig  | grep inet | grep -v inet6 | head -n3 | tail -n1 | awk '{print $2}'`
for file in "ssl.conf" "artifactory.jf.conf"
do
  sed -e "s/localhost/$IP/g" -i $file
done

```
Otherwise, just replace the IP address inside nginx-builder/ssl.conf before running nginx.sh

3.Run the script `sh nginx.sh`

When the script finishes, you'll have a new docker image at your disposal:

`nginx_ssl`

If needed, it will also pull the base nginx image available on the Docker Hub.

### Up & Running ###

-The nginx.sh script is already set to spawn an nginx container. cURL https://$(YOUR_IP):443/v2 to see that the container and nginx booted OK. Nginx should be proxying your Artifactory server @YOUR_IP on port 8081, so make sure your Artifactory server is up and running. 

-Acquire bash access to it by running 'docker exec -it <container_name> /bin/bash'
