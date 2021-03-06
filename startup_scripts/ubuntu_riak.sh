#!/bin/bash

MAINTAINER='Ali Riza Keles, alirza@zetaops.io'

export DEBIAN_FRONTEND='noninteractive'
RIAK_VERSION='2.1.1-1'
IP_ADDRESS=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

echo "$IP_ADDRESS     $(hostname)" >> /etc/hosts


# if strong consistency and riak control are unset, set them to defaults
: ${STRONG_CONSISTENCY:='on'}
: ${RIAK_CONTROL:='off'}

# Install Java 8
apt-get update -qq && apt-get install -y software-properties-common && \
    apt-add-repository ppa:webupd8team/java -y && apt-get update -qq && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

# Install Riak
curl -s https://packagecloud.io/install/repositories/zetaops/riak/script.deb.sh | sudo bash
apt-get install -y riak=$RIAK_VERSION

service riak stop

mount /dev/vdb1 /var/lib/riak

apt-get -qq -y install wget

# Get riak.conf from zetaops public cloud tools
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/conf/riak.conf -O /etc/riak/riak.conf
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/conf/advanced.config -O /etc/riak/advanced.config
chown riak:riak /etc/riak/riak.conf && chmod 755 /etc/riak/riak.conf

# Get Certificate Files
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/certs/cacertfile.pem -O /etc/riak/cacertfile.pem
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/certs/cert.pem -O /etc/riak/cert.pem
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/certs/key.pem -O /etc/riak/key.pem
chown riak:riak /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem
chmod 600 /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem

chown riak:riak /var/lib/riak /var/log/riak
chmod 755 /var/lib/riak /var/log/riak

ulimit -n 65536
echo '* soft nofile 65536' >>   /etc/security/limits.conf
echo '* hard nofile 65536' >>   /etc/security/limits.conf

echo "session required        pam_limits.so" >> /etc/pam.d/common-session-noninteractive
echo "session required        pam_limits.so" >> /etc/pam.d/common-session


sed -i.bak "s/riak@127.0.0.1/riak@${IP_ADDRESS}/" /etc/riak/riak.conf

# set strong consistency and riak_control on or off depends on docker run env vars
sed -i.bak "s/strong_consistency = off/strong_consistency = ${STRONG_CONSISTENCY}/" /etc/riak/riak.conf
sed -i.bak "s/riak_control = off/riak_control = ${RIAK_CONTROL}/" /etc/riak/riak.conf

sleep 5
service riak start

# sleep 10
# apt-get install -y dnsutils

# declare -a nodes=( 1 2 3 4 5 )
# for i in ${nodes[@]}; do
#    IP=$(dig +short zx-ubuntu-riak-0$i.c.zetaops-academic-erp.internal | awk '{ print ; exit }');
#    PONG=$(curl -s http://$IP:8098/ping)
#    if [ -n "$PONG" ] && [ "$PONG" == "OK" ] && [ "$IP" != "$IP_ADDRESS"]; then
#      RESULT=$(riak-admin cluster join riak@$IP)
#      if [ "$RESULT" == *"Success"* ]; then
#          break;
#      fi
#    fi
# done

# create 5 node riak instance based on ubuntu and join cluster on gce platform
# for ((i=1; i<6; i++)) do gcloud -q compute instances create  \
# --zone europe-west1-d --image=ubuntu-14-04 --machine-type "n1-standard-2" \
# --can-ip-forward zx-ubuntu-riak-0$i \
# --metadata-from-file startup-script=ubuntu_riak.sh; done
