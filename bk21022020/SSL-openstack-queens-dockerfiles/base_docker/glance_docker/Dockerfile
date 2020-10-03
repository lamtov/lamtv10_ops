FROM glance_v1:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queen"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE glance

USER root
#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/glance", "/var/lib/glance"]

EXPOSE 9191 9292

USER glance

CMD ["start.sh"]

