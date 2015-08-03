FROM phusion/baseimage:latest
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# Environmental variables
ENV DEBIAN_FRONTEND noninteractive
ENV RIAK_VERSION 2.1.1-1
# Install Java 8

RUN apt-get update -qq && apt-get install -y software-properties-common && \
    apt-add-repository ppa:webupd8team/java -y && apt-get update -qq && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer


RUN ln -s -f /bin/true /usr/bin/chfn

# Install Riak
RUN curl -s https://packagecloud.io/install/repositories/zetaops/riak/script.deb.sh | sudo bash
RUN apt-get install -y riak=${RIAK_VERSION}

# Get riak.conf from zetaops public cloud tools
ADD conf/riak.conf /etc/riak/riak.conf
RUN chown riak:riak /etc/riak/riak.conf
RUN chmod 755 /etc/riak/riak.conf

# Get Certificate Files 
ADD certs/cacertfile.pem /etc/riak/cacertfile.pem
ADD certs/cert.pem /etc/riak/cert.pem
ADD certs/key.pem /etc/riak/key.pem
RUN chown riak:riak /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem
RUN chmod 600 /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem

## Riak service
RUN mkdir -p /etc/service/riak
ADD bin/riak_node_service.sh /etc/service/riak/run
RUN chmod 755 /etc/service/riak/run

# Make Riak's data and log directories volumes
VOLUME /var/lib/riak
VOLUME /var/log/riak

# Open ports for HTTP and Protocol Buffers
EXPOSE 8098 8087 8043


# interncommunicatoin ports
EXPOSE 4369

# distrubution ports
# erlang.distribution.port_range.minimum = 6000
# erlang.distribution.port_range.maximum = 7999
# EXPOSE 6000-7999



# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Leverage the baseimage-docker init system
CMD ["/sbin/my_init", "--quiet"]
