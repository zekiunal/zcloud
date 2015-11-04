#!/bin/bash
git clone https://github.com/zetaops/ulakbus-ui.git /tmp/html

cd /tmp/html
# checkout to the tagged version
git checkout $(git describe --abbrev=0 --tags)

rm -rf  /usr/share/nginx/html
cp -rf /tmp/html/dist /usr/share/nginx/html
nginx -g 'daemon off;'
