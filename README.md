# jsimonetti/gns3-server
[![](https://images.microbadger.com/badges/version/jsimonetti/gns3-server.svg)](https://microbadger.com/images/jsimonetti/gns3-server "Get your own version badge on microbadger.com")][![](https://images.microbadger.com/badges/image/jsimonetti/gns3-server.svg)](https://microbadger.com/images/jsimonetti/gns3-server "Get your own image badge on microbadger.com")][![Docker Pulls](https://img.shields.io/docker/pulls/jsimonetti/gns3-server.svg)][![Docker Stars](https://img.shields.io/docker/stars/jsimonetti/gns3-server.svg)]


## Usage

```
docker run \
    --rm -d \
    --name gns3 \
    --privileged --cap-add SYS_ADMIN \
    -p 3080:3080 \
    -v <data path>/images:/images \
    -v <data path>/symbols:/symbols \
    -v <data path>/configs:/configs \
    -v <data path>/projects:/projects \
    -v <data path>/docker:/docker \
    jsimonetti/gns3-docker:latest 
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 3080` - the port(s)
* `-v /images` - Path to imported appliance images
* `-v /symbols` - Path to symbols
* `-v /configs` - Path to configs
* `-v /projects` - Path to projects
* `-v /docker` - Path to docker data

It is based on alpine-linux edge, for shell access whilst the container is running do `docker exec -it gns3 /bin/sh`.

## Info

* To monitor the logs of the container in realtime `docker logs -f gns3`.
