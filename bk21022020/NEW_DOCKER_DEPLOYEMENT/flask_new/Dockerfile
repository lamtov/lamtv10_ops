FROM ubuntu:16.04
MAINTAINER hieund24@viettel.com.vn

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

LABEL flask_version="queens"

ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE keystone
ENV SHARED_CONF_DIR /usr/share/docker
#Clear cache apt



#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
#COPY keystone.conf /usr/local/bin/keystone.conf


RUN chmod +x /usr/local/bin/*.sh
#Config apache2
#RUN a2dissite 000-default.conf \
#  && echo > /etc/apache2/ports.conf \
#  && echo ServerName localhost >> /etc/apache2/apache2.conf 



RUN apt-get -y install vim net-tools
#RUN apt-get -y install iputils-ping
RUN apt-get -y install telnet 
RUN apt-get -y install python-elasticsearch
RUN pip install --upgrade pip 
#UN apt-get install -y python-openstackclient 
#UN pip install osprofiler
RUN pip install elasticsearch==5.5.3
RUN pip install Flask
RUN apt-get install -y python-virtualenv
RUN python2 -m virtualenv /etc/tracing_server/venv
RUN . /etc/tracing_server/venv/bin/activate
RUN pip install configparser
RUN pip install oslo.utils
RUN pip install six

VOLUME ["/etc/tracing_server"]

EXPOSE 9202

USER root

CMD ["start.sh"]


