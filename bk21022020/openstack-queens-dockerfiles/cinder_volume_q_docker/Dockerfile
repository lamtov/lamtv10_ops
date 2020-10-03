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



RUN apt-get update \
        && apt-get install -y git python-pip python-pymysql python-memcache  python-rtslib  libssl-dev libffi-dev libxml2-dev libxslt1-dev sudo \
        && apt-get clean

#install cinder
RUN pip install -U pip
RUN apt-get update
#RUN  pip install rtslib-fb==2.1.63





RUN  apt-get -y install  cinder-volume  && apt-get clean

#RUN pip install  google-api-python-client==1.4.2 
#RUN pip install -U pip
#UN apt-get -y install lvm2 thin-provisioning-tools
RUN  pip install rtslib-fb==2.1.63
RUN pip install  google-api-python-client==1.4.2



RUN apt-get install -y  ceph-common qemu-utils


#copy sudoer file
COPY cinder_sudoers /etc/sudoers.d/cinder_sudoers



#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/cinder", "/var/lib/cinder"]

EXPOSE 8776

USER cinder

CMD ["start.sh"]
