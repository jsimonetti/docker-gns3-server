# jsimonetti/gns3-server
[![](https://images.microbadger.com/badges/version/jsimonetti/gns3-server.svg)](https://microbadger.com/images/jsimonetti/gns3-server "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/jsimonetti/gns3-server.svg)](https://microbadger.com/images/jsimonetti/gns3-server "Get your own image badge on microbadger.com")[![](https://img.shields.io/docker/pulls/jsimonetti/gns3-server.svg)]()[![](https://img.shields.io/docker/stars/jsimonetti/gns3-server.svg)]()


## Usage

```
docker run \
    --rm -d \
    --name gns3 \
    --net=host --privileged \
    -e BRIDGE_ADDRESS="172.21.1.1/24" \
    -v <data path>:/data \
    jsimonetti/gns3-docker:latest 
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-v /data` - Path to persistant data
* `-e BRIDGE_ADDRESS="172.21.1.1/24"` - Configure the internal NAT network bridge for GNS3

It is based on alpine-linux edge, for shell access whilst the container is running do `docker exec -it gns3 /bin/sh`.

## Info

This container works best when run priviledged and on a network other then dockers' default (host or macvtap for example).
If you run on docker's default network you need to expose all ports used by gns3 and consoles yourself.


* To monitor the logs of the container in realtime `docker logs -f gns3`.
