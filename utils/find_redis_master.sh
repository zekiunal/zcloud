#!/bin/bash
# Walk through etcd keys including redis in /services directory
# we are not interested in container's ip address, we can discover service just with hostname and hostport  
# hostname is part of key /services/redis/redis-t.c.zetaops-academic-erp.internal:redis_t:6379
# hostport is part of value 172.17.0.3:49154
# as registrator2etcd write service informations 
for i in $(etcdctl ls /services | grep redis); do
        KEY=$(etcdctl ls $i)
        arrKEY=( ${KEY//\// } )
        arrHOST=(${arrKEY[2]//:/ })
        REDIS_HOST=${arrHOST[0]}

        REDIS_IP_PORT=$(etcdctl get $(etcdctl ls $i));
        arrIP=(${REDIS_IP_PORT//:/ })
        REDIS_PORT=${arrIP[1]}
        
        MASTER=$(docker run --name redis-check-master --rm --env IP=$REDIS_HOST --env PORT=$REDIS_PORT redis sh -c 'exec redis-cli -h $IP -p $PORT info replication' 2> /dev/null | grep "role:master" | tr 
-d '[[:space:]]')
        if [ "$MASTER" ==  "role:master" ]; then
            echo "A master found living at $REDIS_HOST on port $REDIS_PORT"
        fi
done

