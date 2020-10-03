FROM docker-registry:4000/cinder_api:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE cinder
ENV SHARE_CONF_DIR /usr/share/docker




RUN apt-get update -y && apt-get -y install vim net-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install telnet 
RUN apt-get -y install python-elasticsearch
RUN pip install --upgrade pip 
RUN apt-get install -y python-openstackclient 
RUN pip install osprofiler
RUN pip install elasticsearch==5.5.3



#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh



VOLUME ["/var/log/apache2"]

EXPOSE 8776

USER root

CMD ["start.sh"]



