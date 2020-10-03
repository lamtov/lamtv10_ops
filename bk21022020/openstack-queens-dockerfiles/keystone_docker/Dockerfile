FROM base:q
MAINTAINER lamtv@viettel.com.vn


#ENV https_proxy=https://172.16.30.81:3128
#ENV http_proxy=http://172.16.30.81:3128




LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE keystone
ENV SHARED_CONF_DIR /usr/share/docker
#Clear cache apt

#RUN apt-get -y update && apt-get -y dist-upgrade


RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update -y

#install keystone



RUN apt-get update && apt-get -y install --no-install-recommends apache2 keystone libapache2-mod-wsgi vim net-tools 
RUN apt-get -y install iputils-ping

RUN apt-get -y install telnet


#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
#COPY keystone.conf /usr/local/bin/keystone.conf


RUN chmod +x /usr/local/bin/*.sh

#Config apache2
RUN a2dissite 000-default.conf \
  && echo > /etc/apache2/ports.conf \
  && echo ServerName localhost >> /etc/apache2/apache2.conf 




VOLUME ["/var/log/apache2", "/etc/keystone/credential-keys", "/etc/keystone/fernet-keys"]

#EXPOSE 5000

USER root

CMD ["start.sh"]

