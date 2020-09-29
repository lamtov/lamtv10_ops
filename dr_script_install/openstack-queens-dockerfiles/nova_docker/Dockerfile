FROM base:q
MAINTAINER lamtv@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE nova
ENV SHARED_CONF_DIR /usr/share/docker

#Clear cache apt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update -y

#install nova server
RUN apt-get update -y \
  && apt-get -y install --no-install-recommends nova-api nova-conductor nova-consoleauth nova-novncproxy nova-scheduler nova-placement-api apache2 libapache2-mod-wsgi vim net-tools \
  && apt-get clean

#copy sudoer file
COPY nova_sudoers /etc/sudoers.d/nova_sudoers

#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

#config apache2 for placement-api
RUN a2dissite 000-default.conf \
  && echo > /etc/apache2/ports.conf \
  && echo ServerName localhost >> /etc/apache2/apache2.conf

VOLUME ["/var/log/nova", "/var/lib/nova", "/var/log/apache2"]

EXPOSE 8774 8775 6080 8778

USER nova

CMD ["start.sh"]


