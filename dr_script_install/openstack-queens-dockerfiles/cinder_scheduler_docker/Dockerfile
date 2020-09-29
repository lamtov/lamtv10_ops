FROM base:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE cinder
ENV SHARE_CONF_DIR /usr/share/docker


#Clear cache apt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update -y

#install cinder
RUN apt-get update && apt-get -y install  cinder-api cinder-scheduler  && apt-get clean




#copy sudoer file
COPY cinder_sudoers /etc/sudoers.d/cinder_sudoers

#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

RUN a2dissite 000-default.conf \
	&& echo > /etc/apache2/ports.conf \
	&& echo ServerName localhost >> /etc/apache2/apache2.conf \
    && ln -s /etc/apache2/sites-available/cinder-wsgi.conf /etc/apache2/sites-enabled/cinder-wsgi.conf

VOLUME ["/var/log/apache2","/var/log/cinder"]

EXPOSE 8776

USER cinder

CMD ["start.sh"]

