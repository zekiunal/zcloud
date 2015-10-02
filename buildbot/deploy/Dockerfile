FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip
RUN pip install twisted==15.2.1 buildbot-slave requests
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN chown -R buildbot:buildbot /usr/local/
USER buildbot
WORKDIR /buildslave
COPY createunit.py /buildslave/
COPY buildbot.tac /buildslave/
COPY checkversionupdate.sh /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]