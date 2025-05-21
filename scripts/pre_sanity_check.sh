#!/bin/bash

set -e

for file in \
  /scripts/start.sh \
  /scripts/write_package_flags.sh \
  /scripts/install_openssl.sh \
  /scripts/install_vpcs.sh \
  /scripts/install_python.sh \
  /config.ini \
  /requirements.txt; do

  if [ ! -f "$file" ]; then
    echo "missing: $file"
    exit 1
  fi
done

echo "pre sanity check passed."
