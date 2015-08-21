#!/bin/bash
git clone https://github.com/zetaops/ulakbus-ui.git /tmp/html
copy -rf /tmp/html/dist app /usr/share/nginx/html
nginx -g daemon off
