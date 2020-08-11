#!/bin/bash

download_url="${download_url}"
filename="package.tar.gz"

wget -q -O "$filename" "$download_url"
pip3 install "$filename"
