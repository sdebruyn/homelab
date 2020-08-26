#!/bin/bash

set -e

download_url="${download_url}"
filename="/tmp/package.tar.gz"

wget -q -O "$filename" "$download_url"
pip3 install "$filename"
rm $filename