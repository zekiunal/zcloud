Ulakbus Buildbot Configuration Details



docker build names for docker images

master: zetaops/buildbot
ulakbus: zetaops/ulakbustestslave
ulakbusui: zetaops/ulakbusuitestslave
deploy: zetaops/deployslave

master docker run command: 
CONTAINER_ID=$(docker run -d -p 8010:8010 -p 9989:9989 -p 22 --name zbuild zetaops/buildbot)

dont need to run slaves, master will handle this.