FROM docker-registry:4000/nova:q
MAINTAINER lamtv@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE nova
ENV SHARED_CONF_DIR /usr/share/docker


#copy script
USER root


RUN apt-get update -y && apt-get -y install vim net-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install telnet 
RUN apt-get -y install python-elasticsearch
RUN pip install --upgrade pip 
RUN apt-get install -y python-openstackclient 
RUN pip install osprofiler

RUN pip install elasticsearch==5.5.3

COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
#COPY nova-placement-api.conf /etc/apache2/sites-enabled/nova-placement-api.conf
RUN chmod +x /usr/local/bin/*.sh



VOLUME ["/var/log/nova", "/var/lib/nova", "/var/log/apache2"]

EXPOSE 8774 8775 6080 8778

USER nova

CMD ["start.sh"]



