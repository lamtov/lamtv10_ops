FROM base:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queen"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE glance

#Clear cache apt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update -y

#install glance
RUN apt-get update && apt-get -y install --no-install-recommends glance && apt-get clean

#install ceph client
RUN apt-get update && apt-get -y install --no-install-recommends python-rbd python-rados && apt-get clean


#copy sudoer file
COPY glance_sudoers /etc/sudoers.d/glance_sudoers

#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/glance", "/var/lib/glance"]

EXPOSE 9191 9292

USER glance

CMD ["start.sh"]

