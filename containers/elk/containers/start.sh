#!/bin/bash

service elasticsearch start

counter=0
while [ ! "$(curl localhost:9200 2> /dev/null)" -a $counter -lt 30  ]; do
  sleep 1
  ((counter++))
  echo "waiting for Elasticsearch to be up ($counter/30)"
done


/opt/logstash/bin/logstash -f /logstash_config/logstash.conf
