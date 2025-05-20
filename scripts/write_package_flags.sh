#!/bin/bash

PACKAGE_USE_DIR=/etc/portage/package.use
PACKAGE_ACCEPT_DIR=/etc/portage/package.accept_keywords

if [[ ! -d "/etc/portage" ]]; then
  echo "ERROR! no portage dir"
  exit 1
fi

if [[ ! -f "/etc/portage/make.conf" ]]; then
  echo "ERROR! no make.conf file..."
  exit 1
fi

if [[ ! -d "$PACKAGE_USE_DIR" ]]; then
  mkdir -p "$PACKAGE_USE_DIR"
fi

if [[ ! -d "$PACKAGE_ACCEPT_DIR" ]]; then
  mkdir -p "$PACKAGE_ACCEPT_DIR"
fi

if [[ ! -f "$PACKAGE_USE_DIR/gns3" ]]; then
  touch "$PACKAGE_USE_DIR/gns3"
fi

if [[ ! -f "$PACKAGE_ACCEPT_DIR/gns3" ]]; then
  touch "$PACKAGE_ACCEPT_DIR/gns3"
fi

# global use flag
echo "USE=\"multilib\"" | tee -a /etc/portage/make.conf

# use flag
printf "net-dns/dnsmasq script \nnet-libs/gnutls tools pkcs11\ndev-libs/openssl abi_x86_32\n" | tee -a "$PACKAGE_USE_DIR/gns3" >/dev/null

# accept_keywords (unmask)
printf "net-misc/ubridge ~amd64\napp-emulation/dynamips ~amd64\ndev-python/setuptools ~amd64\n" | tee -a "$PACKAGE_ACCEPT_DIR/gns3" >/dev/null
