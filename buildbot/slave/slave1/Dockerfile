FROM debian:stable
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip
RUN pip install buildbot-slave
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
# Install your build-dependencies here ...
USER buildbot
WORKDIR /buildslave
ENV MASTER_HOST 10.240.162.132
COPY create /buildslave/
RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]