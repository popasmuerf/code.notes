 
 [source](https://www.splunk.com/en_us/blog/tips-and-tricks/hands-on-lab-sandboxing-with-splunk-with-docker.html)
 
 [source](https://www.tekstream.com/containerization-and-splunk-how-docker-and-splunk-work-together/)
 
 ## Pulling/Running an instance
 
 > docker run -d -p 8000:8000  \
 -e "SPLUNK_START_ARGS=--accept-license" \
 -e "SPLUNK_PASSWORD=r3dbl@ck" \
 -name splunk splunk/splunk:latest
 
 
## Pulling and running splunk image instance mounting Docker volumes
 
> docker run --name splunk-mount -v opt-splunk-etc:/opt/splunk/etc -v opt-splunk-var:/opt/splunk/var -d -p 8000:8000 -e SPLUNK_START_ARGS=--accept-license -e SPLUNK_PASSWORD=password splunk/splunk:latest
 
 
 
## Pulling and running splunk image instance mounting Docker volumes
 
> docker run --name splunk-mount -v opt-splunk-etc:/opt/splunk/etc  \
 -v opt-splunk-var:/opt/splunk/var -d -p 8000:8000 \
 -e SPLUNK_START_ARGS=--accept-license -e SPLUNK_PASSWORD="r3dbl@ck" splunk/splunk:latest
 
 
 

## Pulling and running splunk image instance mounting Docker volumes
> docker run --name splunk-mount -v opt-splunk-etc:/opt/splunk/etc  \
 -v opt-splunk-var:/opt/splunk/var -d -p 8000:8000 \
 -e SPLUNK_START_ARGS=--accept-license -e SPLUNK_PASSWORD="r3dbl@ck" splunk/splunk:latest
 
 
## list extant Docker volumes on host
> docker ls volumes



## Change directories on host to Docker volumes directories
cd /var/lib/docker/volumes



 
 
 
## Run instance  bash shell 
> docker exec -it splunk-mount bash
 
 
## Stop instance
>docker splunk-mount stop
 
## rm image 
> docker rm splunk-mount
 
 
## Docker list volme to see if those volumes are still there(spoiler alert...they are)
> docker volume ls
 
## Remove those volumes 
>docker volume rm <volume>
 
 
 ## Docker kill container and force volume mount clean up.
 docker rm -vf <container_name|id>
 
 docker rm -vf 1f34fcbbe085
 
 
 (base) mrblack@pop-os:~$ docker container stop splunk-mount
splunk-mount
(base) mrblack@pop-os:~$ docker container rm  splunk-mount
splunk-mount

