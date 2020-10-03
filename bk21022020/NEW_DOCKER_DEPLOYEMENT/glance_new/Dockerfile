FROM docker-registry:4000/glance:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queen"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE glance

USER root
#copy script

RUN apt-get -y update &&  apt-get -y install vim net-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install telnet 
RUN apt-get -y install python-elasticsearch
RUN pip install --upgrade pip 
RUN apt-get install -y python-openstackclient 
RUN pip install osprofiler
RUN pip install elasticsearch==5.5.3

COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/glance", "/var/lib/glance"]

EXPOSE 9191 9292

USER glance

CMD ["start.sh"]


