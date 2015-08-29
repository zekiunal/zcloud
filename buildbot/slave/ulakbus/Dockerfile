FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   libffi-dev \
   libssl-dev \
   git
RUN pip install twisted==15.2.1 buildbot-slave
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
# RUN sed -Ei 's/(\%buildbot ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN chown -R buildbot:buildbot /usr/local/
# Install your build-dependencies here ...
USER buildbot
WORKDIR /buildslave
ENV PYOKO_SETTINGS 'ulakbus.settings'
ENV RIAK_SERVER 'zx-lb-01.c.zetaops-academic-erp.internal'
ENV RIAK_PORT '8098'
ENV RIAK_PROTOCOL 'http'

COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]