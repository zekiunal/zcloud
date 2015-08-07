# # Run buildbot
# CONTAINER_ID=$(docker run -d -p 8010:8010 -p 22 buildbot)
#
# # Test buildbot master is listening
# wget -qO- localhost:8010
# # Browse the url localhost:8010
# # Log into container  (username: admin   password: admin)
# ssh -p $(docker port $CONTAINER_ID 22 | cut -d: -f 2) admin@localhost
from ubuntu:14.04

RUN /bin/echo -e "\
    deb http://archive.ubuntu.com/ubuntu trusty main universe\n\
    deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" > \
    /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip python-dev \
    supervisor git sudo ssh
RUN git clone https://github.com/zetaops/buildbot.git
RUN cd buildbot/master && python setup.py build && python setup.py install
RUN pip install six==1.6.1 docker-py buildbot_www==0.9.0b1 buildbot_slave

# Set ssh superuser (username: admin   password: admin)
RUN mkdir /data /var/run/sshd
RUN useradd -m -d /data/buildbot -p sa1aY64JOY94w admin
RUN sed -Ei 's/adm:x:4:/admin:x:4:admin/' /etc/group
RUN sed -Ei 's/(\%admin ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers

# Create buildbot configuration
RUN cd /data/buildbot; buildbot create-master master
RUN chown -R admin:admin /data/buildbot/master

# RUN cd /data/buildbot; sudo -u admin sh -c \
#     "buildslave create-slave ulakbus-slave localhost:9989 ulakbus-slave 3V6SBwag"
#     "buildslave create-slave ulakbus-ui-slave localhost:9989 ulakbus-slave YdybP9I4"
#     "buildslave create-slave ulakbus-free-slave localhost:9989 ulakbus-slave q8J4fjJG"

# Set supervisord buildbot and sshd processes
RUN /bin/echo -e "[program:sshd]\ncommand=/usr/sbin/sshd -D\n" > \
    /etc/supervisor/conf.d/sshd.conf
RUN /bin/echo -e "\
[program:buildmaster]\n\
command=twistd --nodaemon --no_save -y buildbot.tac\n\
directory=/data/buildbot/master\n\
user=admin\n" > /etc/supervisor/conf.d/buildbot.conf

# Setup running docker container buildbot process
# Make host port 8010 match container port 8010
EXPOSE :8010
# Expose container port 22 to a random port in the host.
# expose 22
CMD ["/usr/bin/supervisord", "-n"]
COPY master/master.cfg /data/buildbot/master/