#!/bin/bash

set -e

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

pushd /tmp || exit

wget https://github.com/GNS3/vpcs/archive/refs/heads/master.tar.gz
tar xvf vpcs-master.tar.gz
pushd ./vpcs-master/src || exit

./mk.sh amd64
mv ./vpcs /usr/bin/vpcs

popd || exit
popd || exit
