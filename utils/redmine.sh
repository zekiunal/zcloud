#!/bin/bash
### BEGIN INIT INFO
# Provides:          redmine passenger in standalone
# Required-Start:    $remote_fs $network $syslog
# Required-Stop:     $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     true
# Short-Description: Start/stop redmine pm ulakbus web site
### END INIT INFO

# zetaops
# passenger simple init script for ulakbus pm redmine
# just start and stop
# make executable and place into /etc/init/
# update-rc.d redmine defaults
# thanks https://gist.github.com/cblunt/5701286

PASSENGER="passenger"

# wont use these vars, defined passenger conf file
ADDRESS=0.0.0.0
PORT=3000
ENVIRONMENT=production
APP_NAME=redmine

APP_DIR="/mnt/data/app"
USER="redmine"
SET_PATH="cd $APP_DIR"
PRE_CMD=""
START_CMD="bundle exec passenger start  -d"
CMD="$SET_PATH; $PRE_CMD $START_CMD"

. /lib/lsb/init-functions

case "$1" in
  start)
    echo "Starting $APP_NAME passenger"
    echo "su - $USER -c \"$CMD\""
    su - $USER -c "$CMD"
    ;;
  stop)
    echo "Stopping $APP_NAME passenger"
    cd $APP_DIR
    $PASSENGER stop -p $PORT
    ;;
  restart)
    echo "Restarting $APP_NAME passenger"
    cd $APP_DIR
    $PASSENGER stop -p $PORT

    echo "su - $USER -c \"$CMD\""
    su - $USER -c "$CMD"
    ;;
  *)
    echo "Usage: $0 start|stop" >&2
    exit 3
    ;;
esac