FROM mysql:latest

MAINTAINER Ali Riza Keles, alirza@zetaops.io
ENV DEBIAN_FRONTEND noninteractive

ADD data /data


RUN sed -i '/\[mysqld\]/a lower_case_table_names=1' /etc/mysql/my.cnf

