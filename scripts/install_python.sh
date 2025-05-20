#!/bin/bash

set -euo pipefail
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' exit

pushd /tmp || exit

wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
tar xf Python-3.11.9.tgz

pushd ./Python-3.11.9 || exit
./configure --prefix=/opt/python-3.11.9 --enable-optimizations --with-ensurepip=install
make -j"$(nproc)"
make install

popd || exit
popd || exit

/opt/python-3.11.9/bin/python3 -m pip install --upgrade pip
/opt/python-3.11.9/bin/pip3 install -r /requirement.txt
