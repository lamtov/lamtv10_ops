FROM testmasakarimonitor:q
MAINTAINER lamtv@viettel.com.vn

LABEL openstack_version="rocky"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE masakari-monitors

ENV MASAKARI_REPO https://github.com/openstack/masakari-monitors/tree/stable/rocky
ENV MASAKARI_BRANCH stable/rocky
ENV SHARED_CONF_DIR /usr/share/docker
ENV INSTALLATION_DIR /usr/src
ENV MASAKARI_LOG_DIR /var/log/masakari
ENV MASAKARI_CONF_DIR /etc/masakarimonitors

RUN apt-get update \
        && apt-get install -y python-openstackclient python-pip python-setuptools python3-setuptools \
        && apt-get install -y pkg-config python-tox pkg-config libvirt-dev python-dev libxslt1-dev zlib1g-dev \
        && apt-get install -y vim git tcpdump iputils-ping \
        && apt-get install -y pacemaker \
	&& apt-get clean

#RUN git clone -b ${OPENSTACK_CLIENT_BRANCH} ${OPENSTACK_CLIENT_REPO} ${INSTALLATION_DIR}/python-masakariclient
RUN git clone https://github.com/openstack/masakari-monitors.git -b stable/rocky  ${INSTALLATION_DIR}/masakari-monitors 

### CREATE EXECUTABLE SHELL SCRIPTS###
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

RUN cd ${INSTALLATION_DIR}/masakari-monitors \ 
        && pip install -r requirements.txt \
        && python setup.py install
RUN mkdir -p ${MASAKARI_LOG_DIR} 
RUN mkdir -p ${MASAKARI_CONF_DIR} 
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
RUN ln -s /usr/bin/tcpdump /usr/sbin/tcpdump
RUN apt-get install -y systemd

RUN systemctl enable pacemaker && systemctl enable corosync

CMD ["start.sh"]

