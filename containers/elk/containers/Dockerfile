FROM java:8-jre
MAINTAINER Cem Guresci ZetaOps 

ENV DEBIAN_FRONTEND noninteractive



################### ELASTICSEARCH ###################

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV ELASTICSEARCH_VERSION 1.7.1
ENV ELASTICSEARCH_URL localhost:9200
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/${ELASTICSEARCH_VERSION%.*}/debian stable main" > /etc/apt/sources.list.d/elasticsearch.list

RUN apt-get update \
	&& apt-get install elasticsearch=$ELASTICSEARCH_VERSION \
	&& rm -rf /var/lib/apt/lists/* 

ENV PATH /usr/share/elasticsearch/bin:$PATH

COPY elasticsearch_config /usr/share/elasticsearch/config

VOLUME /usr/share/elasticsearch/data



#################### KIBANA #####################

RUN groupadd -r kibana && useradd -r -g kibana kibana

RUN apt-get update && apt-get install -y ca-certificates curl --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV KIBANA_VERSION 4.1.1
ENV KIBANA_SHA1 d43e039adcea43e1808229b9d55f3eaee6a5edb9

RUN set -x \
	&& curl -fSL "https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz" -o kibana.tar.gz \
	&& echo "${KIBANA_SHA1}  kibana.tar.gz" | sha1sum -c - \
	&& mkdir -p /opt/kibana \
	&& tar -xz --strip-components=1 -C /opt/kibana -f kibana.tar.gz \
	&& rm kibana.tar.gz

ENV PATH /opt/kibana/bin:$PATH

COPY ./kibana_config/kibana.yml /opt/kibana/config/kibana.yml 

################# LOGSTASH ####################


RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV LOGSTASH_MAJOR 1.5
ENV LOGSTASH_VERSION 1:1.5.3-1

RUN echo "deb http://packages.elasticsearch.org/logstash/${LOGSTASH_MAJOR}/debian stable main" > /etc/apt/sources.list.d/logstash.list

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends logstash=$LOGSTASH_VERSION \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /opt/logstash/bin:$PATH

COPY ./logstash_config/logstash.conf /logstash_config/logstash.conf

RUN mkdir -p /opt/logstash/patterns \
	&&chown logstash:logstash /opt/logstash/patterns

############### SUPERVISORD ################



RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#############################################

COPY ./start.sh /start.sh
RUN chmod +x start.sh

EXPOSE 5601 9200 9300 5000

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
