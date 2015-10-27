#!/bin/bash

service elasticsearch start

counter=0
while [ ! "$(curl localhost:9200 2> /dev/null)" -a $counter -lt 30  ]; do
  sleep 1
  ((counter++))
  echo "waiting for Elasticsearch to be up ($counter/30)"
done

sed -i "s/SMTPUSER/$SMTPUSER/g" /logstash_config/logstash.conf
sed -i "s/SMTPPASSWORD/$(echo $SMTPPASSWORD | sed -e 's/[]\/$*.^|[]/\\&/g')/" /logstash_config/logstash.conf

/opt/logstash/bin/logstash -f /logstash_config/logstash.conf
