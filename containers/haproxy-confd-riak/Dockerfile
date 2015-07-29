FROM haproxy
MAINTAINER Ali Riza Keles, aliriza@zetaops.io

RUN apt-get update \
	&& apt-get install -y curl \
	&& rm -rf /var/lib/apt/lists/*

ENV CONFDVERSION 0.9.0

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu


ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFDVERSION}/confd-${CONFDVERSION}-linux-amd64 \
    /usr/local/bin/confd
RUN chmod u+x /usr/local/bin/confd

# confd configuration
ADD haproxy.cfg /etc/confd/templates/haproxy.cfg
ADD haproxy.toml /etc/confd/conf.d/haproxy.toml
ADD configuration.toml /etc/confd/confd.toml

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8087
EXPOSE 8098
