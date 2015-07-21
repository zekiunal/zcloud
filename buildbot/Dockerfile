# This file is part of Buildbot.  Buildbot is free software: you can
# redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, version 2.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51
# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Copyright Buildbot Team Members
#
#
# VERSION         1.1
# DOCKER_VERSION  0.6.1-dev
# AUTHOR          Daniel Mizyrycki <daniel@dotcloud.com>
# DESCRIPTION     Build buildbot tutorial into a runnable linux container
#                 with all dependencies installed as a playground sandbox
#
# # To build:
#
# # Install docker (http://docker.io)
#
# # Download buildbot Dockerfile
# wget https://raw.github.com/buildbot/buildbot/master/master/contrib/Dockerfile
#
# # Build buildbot image
# docker build -t buildbot - < Dockerfile
#
# # Run buildbot
# CONTAINER_ID=$(docker run -d -p 8010:8010 -p 22 buildbot)
#
# # Test buildbot master is listening
# wget -qO- localhost:8010
#
# # See buildbot in action.
# # Browse the url localhost:8010
# # Log into the web GUI (username: pyflakes   password: pyflakes)
# # Click on the Waterfall link (http://localhost:8010/waterfall)
# #   runtests builder should be idle
# # Click on runtests builder link (http://localhost:8010/builders/runtests)
# # Click on Force Build
# # Click on Waterfall link again (http://localhost:8010/waterfall)
# # If everything went well, you should be greeted with a green build.
#
# # From here, you can log into the docker container to understand better what
# # is happening behind the scenes, play with master.cfg in a safe sandbox and
# # make your buildbot playground useful for your own projects.
#
# # Log into container  (username: admin   password: admin)
# ssh -p $(docker port $CONTAINER_ID 22 | cut -d: -f 2) admin@localhost
#
# Base docker image
from ubuntu:14.04

# Make dpkg happy with the upstart issue
## appears to not be necessary anymore --dustin
#run dpkg-divert --local --rename --add /sbin/initctl
#run ln -s /bin/true /sbin/initctl

# Install buildbot and its dependencies

RUN /bin/echo -e "\
    deb http://archive.ubuntu.com/ubuntu trusty main universe\n\
    deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" > \
    /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip python-dev \
    supervisor git sudo ssh
RUN pip install six==1.6.1 docker-py buildbot==0.9.0b1 buildbot_www==0.9.0b1 buildbot_slave

# Set ssh superuser (username: admin   password: admin)
RUN mkdir /data /var/run/sshd
RUN useradd -m -d /data/buildbot -p sa1aY64JOY94w admin
RUN sed -Ei 's/adm:x:4:/admin:x:4:admin/' /etc/group
RUN sed -Ei 's/(\%admin ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers

# Create buildbot configuration
RUN cd /data/buildbot; sudo -u admin sh -c "buildbot create-master master"

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
user=admin\n\n\ " > \
# [program:buildworker]\n\
# command=twistd --nodaemon --no_save -y buildbot.tac\n\
# directory=/data/buildbot/ulakbus-slave\n\
# user=admin\n" > \
    /etc/supervisor/conf.d/buildbot.conf

# Setup running docker container buildbot process
# Make host port 8010 match container port 8010
EXPOSE :8010
# Expose container port 22 to a random port in the host.
# expose 22
CMD ["/usr/bin/supervisord", "-n"]
COPY master/master.cfg /data/buildbot/master/