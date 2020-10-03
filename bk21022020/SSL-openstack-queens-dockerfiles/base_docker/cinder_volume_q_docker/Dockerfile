FROM base:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE cinder
ENV SHARE_CONF_DIR /usr/share/docker


USER root
#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/cinder", "/var/lib/cinder"]

EXPOSE 8776

USER cinder

CMD ["start.sh"]
