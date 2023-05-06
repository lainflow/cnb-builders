#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${HTTP_PROXY:-}" ]]; then
  curl_cmd="curl --proxy $HTTP_PROXY -fSL"
else
  curl_cmd="curl -fSL"
fi

PYTHON_VERSION=3.9.9
PYTHON_DISTRO=python-$PYTHON_VERSION
PYTHON_URL=https://www.python.org/ftp/python/$PYTHON_VERSION/$PYTHON_DISTRO.tar.xz
PYTHON_PATH=/usr/local

$curl_cmd $PYTHON_URL -o $PYTHON_DISTRO.tar.xz
tar -xJf $PYTHON_DISTRO.tar.xz
cd $PYTHON_DISTRO
./configure --prefix=$PYTHON_PATH
make -j$(nproc)
make install
cd ..
rm -rf $PYTHON_DISTRO*

exit 0
