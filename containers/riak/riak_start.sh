#!/bin/bash
sudo sysctl -p /home/core/sysctl_vars
docker pull zetaops/riak:2.1.1-1
source /etc/environment
echo $COREOS_PRIVATE_IPV4
IGNORED_PORTS=""; for ((i=11000; i<13000; i++)) do IGNORED_PORTS+="-e SERVICE_"$i"_IGNORE=true "; done;
IGNORED_PORTS+="-e SERVICE_8985_IGNORE=true "
IGNORED_PORTS+="-e SERVICE_4369_IGNORE=true "
IGNORED_PORTS+="-e SERVICE_8099_IGNORE=true "
IGNORED_PORTS+="-e SERVICE_8093_IGNORE=true "
docker run -d -h $(hostname) --name $(hostname -s) --env IP_ADDRESS=$COREOS_PRIVATE_IPV4 --env STRONG_CONSISTENCY=on --env RIAK_CONTROL=off -p 8043:8043 -p 8087:8087 -p 8098:8098 -p 4369:4369 -p 8093:8093 -p 8099:8099 -p 8985:8985 -p 11000-12999:11000-12999 -v /mnt/data/riak/data:/var/lib/riak -v /mnt/data/riak/log:/var/log/riak ${IGNORED_PORTS} zetaops/riak:2.1.1-1

