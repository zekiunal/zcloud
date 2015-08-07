FROM phusion/baseimage:0.9.16
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# Environmental variables
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list
RUN apt-get update -qq && apt-get -y upgrade
RUN apt-get install -y tar curl nano wget dialog net-tools

## python2.7  zaerp zengine ipython
RUN apt-get install -y python2.7 python-dev python-distribute python-setuptools
RUN apt-get install -y git
RUN apt-get install -y build-essential libssl-dev libffi-dev

RUN easy_install --upgrade pip
RUN pip install riak -q
#RUN pip install -e git+https://github.com/basho/riak-python-client.git#egg=riak
RUN pip install ipython -q
RUN pip install git+git://github.com/didip/beaker_extensions.git

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

# Enable insecure SSH key
# See: https://github.com/phusion/baseimage-docker#using_the_insecure_key_for_one_container_only
RUN /usr/sbin/enable_insecure_key

RUN mkdir -p /etc/service/app
ADD app.sh /etc/service/app/run
RUN chmod 755 /etc/service/app/run


# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Leverage the baseimage-docker init system
CMD ["/sbin/my_init", "--quiet"]
