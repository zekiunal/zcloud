FROM debian:stable
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip
RUN pip install buildbot-slave requests
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN chown -R buildbot:buildbot /usr/local/
USER buildbot
WORKDIR /buildslave
COPY createunit.py /buildslave/
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]