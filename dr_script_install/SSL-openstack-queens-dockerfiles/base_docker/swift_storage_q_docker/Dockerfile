FROM base:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE swift
ENV SHARE_CONF_DIR /usr/share/docker


#Clear cache apt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update -y



RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache  python-rtslib  libssl-dev libffi-dev libxml2-dev libxslt1-dev sudo \
        && apt-get clean

#install cinder
RUN pip install -U pip
RUN apt-get update
#RUN  pip install rtslib-fb==2.1.63





RUN  apt-get -y install  swift swift-account swift-container swift-object  && apt-get clean


#install ceph client
RUN apt-get update && apt-get -y install --no-install-recommends python-rbd python-rados && apt-get clean

RUN echo "tovanlam1"
#copy sudoer file
COPY swift_sudoers /etc/sudoers.d/swift_sudoers



#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/swift", "/var/lib/swift"]

EXPOSE 6201 6200 6202

USER root

CMD ["start.sh"]
