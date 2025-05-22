#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
DOCKER_DIR="$(dirname "$SCRIPT_DIR")"
PRESERVE_DATA_DIR="$HOME/gns3-server"

if [[ ! -d "$PRESERVE_DATA_DIR" ]]; then
  mkdir -pv "$PRESERVE_DATA_DIR"
fi

docker build -t joepasss/gns3-server "$DOCKER_DIR" &&
  docker run \
    --rm -d \
    --name gns3 \
    --net=host --previleged \
    -e BRIDGE_ADDRESS="172.21.1.2/24" \
    -v "$HOME/gns3-server":/data \
    joepasss/gns3-server
