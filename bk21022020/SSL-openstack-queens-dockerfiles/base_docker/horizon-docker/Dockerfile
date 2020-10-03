FROM horizon_v1:q
MAINTAINER lamtv@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE horizon
ENV SHARED_CONF_DIR /usr/share/docker


#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
COPY django.wsgi /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi


RUN chmod +x /usr/local/bin/*.sh


VOLUME ["/var/log/apache2"]

EXPOSE 80 443

USER root

CMD ["start.sh"]
