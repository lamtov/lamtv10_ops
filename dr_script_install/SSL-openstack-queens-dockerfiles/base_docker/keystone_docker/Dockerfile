FROM keystone_v1:q
MAINTAINER lamtv@viettel.com.vn


LABEL openstack_version="queens"

ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE keystone
ENV SHARED_CONF_DIR /usr/share/docker
#Clear cache apt



#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
#COPY keystone.conf /usr/local/bin/keystone.conf


RUN chmod +x /usr/local/bin/*.sh
RUN  a2enmod ssl

#Config apache2
#RUN a2dissite 000-default.conf \
#  && echo > /etc/apache2/ports.conf \
#  && echo ServerName localhost >> /etc/apache2/apache2.conf 




VOLUME ["/var/log/apache2", "/etc/keystone/credential-keys", "/etc/keystone/fernet-keys"]

#EXPOSE 5000

USER root

CMD ["start.sh"]

