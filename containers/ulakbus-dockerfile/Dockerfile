FROM python:2.7-slim
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# env vars for ulakbus
ENV PYTHONIOENCODING UTF-8
ENV ZENGINE_SETTINGS ulakbus.settings
ENV LC_CTYPE en_US.UTF-8
ENV PYOKO_SETTINGS ulakbus.settings
ENV PYTHONUNBUFFERED 1

# defaults, will be overridden by run script, -e RIAK_SERVER=RIAK_LB
ENV RIAK_PORT 8098
ENV REDIS_SERVER 127.0.0.1:6379
ENV RIAK_SERVER 127.0.0.1
ENV RIAK_PROTOCOL http

# libssl and libffi dev packages for riak client
RUN apt-get install -y git libssl-dev libffi-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

ADD app.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
