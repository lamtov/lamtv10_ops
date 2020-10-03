FROM neutron_v1:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE neutron


USER root
#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/neutron", "/var/lib/neutron", "/run"]

EXPOSE 9696

USER neutron

CMD ["start.sh"]

