#!/bin/sh
dockerd --storage-driver=vfs &
gns3server -L -A
