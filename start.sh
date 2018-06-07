#!/bin/sh
if [ "${CONFIG}x" == "x" ]; then
	CONFIG=/data/config.ini
fi

if [ -z $CONFIG ]; then
	cp /config.ini /data
fi

brctl addbr virbr0
ip link set dev virbr0 up
if [ "${BRIDGE_ADDRESS}x" == "x" ]; then
  BRIDGE_ADDRESS=172.21.1.1/24
fi
ip ad add ${BRIDGE_ADDRESS} dev virbr0
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

dockerd --storage-driver=vfs --data-root=/data/docker/ &
gns3server -A --config /data/config.ini
