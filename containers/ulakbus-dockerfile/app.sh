#!/bin/sh

# create app directory and clone zaerp master
mkdir /app
cd /app
git clone https://github.com/zetaops/ulakbus.git

cd /app/ulakbus
pip install -r requirements.txt
ln -s /app/ulakbus/ulakbus /usr/local/lib/python2.7/dist-packages/


# add zaerp user and set /app as home
/usr/sbin/useradd --home-dir /app --shell /bin/bash --comment 'zaerp operations' ulakbus
chown -R ulakbus:ulakbus /app
cd /app/ulakbus/ulakbus

python runserver.py
