FROM phusion/baseimage:0.9.16
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# Environmental variables
ENV DEBIAN_FRONTEND noninteractive

# Install Java 8

RUN apt-get update -qq && apt-get install -y software-properties-common && \
    apt-add-repository ppa:webupd8team/java -y && apt-get update -qq && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

# Install Riak
RUN curl https://packagecloud.io/install/repositories/zetaops/riak/script.deb | sudo bash
RUN apt-get install -y riak

# Get riak.conf from zetaops public cloud tools
RUN curl https://raw.githubusercontent.com/zetaops/cloud-tools/master/confs/riak/riak.conf > /etc/riak/riak.conf
RUN chown riak:riak /etc/riak/riak.conf
RUN chmod 755 /etc/riak/riak.conf

# Get Certificate Files 
RUN curl https://raw.githubusercontent.com/zetaops/cloud-tools/master/certs/riak/cacertfile.pem > /etc/riak/cacertfile.pem
RUN curl https://raw.githubusercontent.com/zetaops/cloud-tools/master/certs/riak/cert.pem > /etc/riak/cert.pem
ADD certs/key.pem /etc/riak/key.pem
RUN chown riak:riak /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem
RUN chmod 600 /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem

## Riak service
RUN mkdir -p /etc/service/riak
ADD bin/riak_service.sh /etc/service/riak/run
RUN chmod 755 /etc/service/riak/run

# Make Riak's data and log directories volumes
VOLUME /var/lib/riak
VOLUME /var/log/riak

#riak-cs:
RUN curl -s https://packagecloud.io/install/repositories/basho/riak-cs/script.deb.sh | sudo bash
RUN apt-get install riak-cs=2.0.1-1


#stanchion:
RUN curl -s https://packagecloud.io/install/repositories/basho/stanchion/script.deb.sh | sudo bash
RUN apt-get install stanchion=2.0.0-1

VOLUME /var/lib/riak-cs
VOLUME /var/log/riak-cs
VOLUME /var/lib/stanchion
VOLUME /var/log/stanchion


# Open ports for HTTP and Protocol Buffers
EXPOSE 8098 8087 8043

# Enable insecure SSH key
# See: https://github.com/phusion/baseimage-docker#using_the_insecure_key_for_one_container_only
RUN /usr/sbin/enable_insecure_key

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Leverage the baseimage-docker init system
CMD ["/sbin/my_init", "--quiet"]


##
# 
# build it
# docker build -t="zetaops/riaknode" .
#
# run after it
# docker run -i -t  -v /var/log/riak:/path/to/local/log -v /var/lib/riak:/pat/to/local/data -p 8098 -p 8087 -p 8043 -name 'nodename' -d zetaops/riaknode /sbin/my_init -- bash -l
#
#
##

