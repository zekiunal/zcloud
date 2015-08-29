FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   libfreetype \
   git \
   curl \
   nodejs
RUN pip install twisted==15.2.1 buildbot-slave

RUN update-alternatives --install /usr/bin/node nodejs /usr/bin/nodejs 100
RUN curl https://www.npmjs.com/install.sh | sh

RUN node -v
RUN npm -v
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
#RUN sed -Ei 's/(\buildbot ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers
RUN echo 'buildbot ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN chown -R buildbot:buildbot /usr/local/
# Install your build-dependencies here ...
USER buildbot
WORKDIR /buildslave
ENV PHANTOMJS_BIN /buildslave/runuitests/build/node_modules/phantomjs/lib/phantom/bin/phantomjs
COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]