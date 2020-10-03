FROM base:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE neutron

#Clear cache apt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update -y

#install neutron
RUN apt-get update -y \
  && apt-get -y install --no-install-recommends iproute2 iputils-ping net-tools  neutron-plugin-ml2 neutron-server neutron-plugin-openvswitch-agent openvswitch-switch python-openvswitch neutron-dhcp-agent neutron-metadata-agent \
  && apt-get clean

#copy sudoer file
COPY neutron_sudoers /etc/sudoers.d/neutron_sudoers

#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/neutron", "/var/lib/neutron", "/run"]

EXPOSE 9696

USER neutron

CMD ["start.sh"]

