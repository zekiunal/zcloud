FROM phusion/baseimage:latest
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# Environmental variables
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y tomcat7 mysql-server

ADD unitime /opt/unitime
RUN cp /opt/unitime/web/UniTime.war /var/lib/tomcat7/webapps/
RUN cp /opt/unitime/mysql-connector-java-5.1.36/mysql-connector-java-5.1.36-bin.jar \
                                               /usr/share/java/mysql-connector-java-5.1.36-bin.jar
RUN ln -s /usr/share/java/mysql-connector-java-5.1.36-bin.jar /usr/share/tomcat7/lib/mysql-connector-java-5.1.36-bin.jar
RUN sed -i.bak "s/Xmx128m/Xmx1024m/" /etc/default/tomcat7

RUN service mysql restart \
    && mysql -uroot -f < /opt/unitime/doc/mysql/schema.sql \
    && mysql -uroot < /opt/unitime/doc/mysql/blank-data.sql



# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Leverage the baseimage-docker init system
CMD ["/sbin/my_init", "--quiet"]