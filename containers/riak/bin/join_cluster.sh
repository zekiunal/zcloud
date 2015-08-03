#!/bin/bash
# Walk through etcd keys including redis in /services directory
# we are not interested in container's ip address, we can discover service just with hostname and hostport  
# hostname is part of key /services/redis/redis-t.c.zetaops-academic-erp.internal:redis_t:6379
# hostport is part of value 172.17.0.3:49154
# as registrator2etcd write service informations 
RIAK_NODES=""
for i in $(etcdctl ls /services/riak-8098); do
        
        KEY=$(etcdctl ls $i)

        arrKEY=( ${KEY//\// } )
        arrHOST=(${arrKEY[2]//:/ })
        RIAK_HOST=${arrHOST[0]}

        RIAK_IP_PORT=$(etcdctl get $(etcdctl ls $i));
        arrIP=(${RIAK_IP_PORT//:/ })
        RIAK_PORT=${arrIP[1]}
        
        RESPONSE=$(curl $RIAK_HOST:$RIAK_PORT/ping  2> /dev/null | grep "OK" | tr -d '[[:space:]]')
        
        if [ "$RESPONSE" ==  "OK" ]; then
            RIAK_NODES+="$RIAK_HOST:$RIAK_PORT,"
        fi
done
echo ${RIAK_NODES%?}
