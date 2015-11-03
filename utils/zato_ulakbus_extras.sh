#!/usr/bin/env bash
sudo su - ulakbus
virtualenv --no-site-packages ulakbusenv
source ulakbusenv/bin/activate
pip install riak
pip install git+https://github.com/zetaops/pyoko.git
pip install passlib
pip install git+https://github.com/didip/beaker_extensions.git
pip install git+https://github.com/zetaops/zengine.git
pip install git+https://github.com/zetaops/ulakbus.git