#!/bin/bash

set -euo pipefail

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

pushd /tmp || exit

wget https://www.openssl.org/source/old/0.9.x/openssl-0.9.8zh.tar.gz
tar xvf openssl-0.9.8zh.tar.gz

pushd ./openssl-0.9.8zh || exit
CC="gcc -m32" ./Configure linux-generic32 --prefix=/opt/openssl-0.9.8 shared
make -j"$(nproc)"
make install

pushd /opt/openssl-0.9.8/lib || exit
ln -sf libcrypto.so.0.9.8 libcrypto.so.4

echo "/opt/openssl-0.9.8/lib" | tee /etc/ld.so.conf.d/openssl-0.9.8.conf
ldconfig

popd || exit
popd || exit
popd || exit
