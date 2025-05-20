#!/bin/bash

set -e

if [[ ! -d /tmp ]]; then
  mkdir /tmp
fi

pushd /tmp || exit

git clone https://github.com/GNS3/vpcs/
pushd ./vpcs/src || exit

./mk.sh amd64
mv ./vpcs /usr/bin/vpcs

popd || exit
popd || exit
