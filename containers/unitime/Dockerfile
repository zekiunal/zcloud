FROM tomcat:7-jre8
MAINTAINER Ali Riza Keles, alirza@zetaops.io
ENV DEBIAN_FRONTEND noninteractive

COPY unitime/web/UniTime.war /usr/local/tomcat/webapps/
COPY mysql-connector-java-5.1.37/mysql-connector-java-5.1.37-bin.jar \
                                               /usr/local/tomcat/lib/mysql-connector-java-5.1.37-bin.jar

RUN echo -e 'log4j.appender.unitimeLogFile=org.apache.log4j.DailyRollingFileAppender \
log4j.appender.unitimeLogFile.File=${catalina.base}/logs/unitime-debug.log \
log4j.appender.unitimeLogFile.DatePattern='\''.'\''yyyy-MM-dd \
log4j.appender.unitimeLogFile.Append=true \
log4j.appender.unitimeLogFile.layout=org.apache.log4j.PatternLayout \
log4j.appender.unitimeLogFile.layout.ConversionPattern=[%-d{MM/dd/yy HH:mm:ss}] %-6p %c{1} -> %m%n \
log4j.logger.org.unitime=DEBUG, unitimeLogFile' >> /usr/local/tomcat/conf/catalina.properties

EXPOSE 8080
CMD ["catalina.sh", "run"]

