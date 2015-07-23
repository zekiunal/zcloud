FROM debian:stable
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   git \
   curl \
   nodejs
RUN pip install buildbot-slave

RUN update-alternatives --install /usr/bin/node nodejs /usr/bin/nodejs 100
RUN curl https://www.npmjs.com/install.sh | sh

RUN node -v
RUN npm -v

RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
#RUN sed -Ei 's/(\%buildbot ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
# Install your build-dependencies here ...
USER buildbot
WORKDIR /buildslave
ENV MASTER_HOST 10.240.162.132
COPY create /buildslave/
RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]