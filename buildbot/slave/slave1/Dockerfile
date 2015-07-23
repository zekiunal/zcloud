FROM debian:stable
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   git
RUN pip install buildbot-slave
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
# RUN sed -Ei 's/(\%buildbot ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN chown -R buildbot:buildbot /usr/local/
# Install your build-dependencies here ...
USER buildbot
WORKDIR /buildslave
ENV MASTER_HOST 10.240.162.132
ENV PYOKO_SETTINGS 'ulakbus.settings'
ENV RIAK_SERVER '146.148.118.71'
ENV RIAK_PORT '8098'
ENV RIAK_PROTOCOL 'http'

COPY create /buildslave/
RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]