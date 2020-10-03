FROM cinder_api_v1:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE cinder
ENV SHARE_CONF_DIR /usr/share/docker



#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh



VOLUME ["/var/log/apache2"]

EXPOSE 8776

USER root

CMD ["start.sh"]


