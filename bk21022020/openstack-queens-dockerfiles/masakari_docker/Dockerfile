FROM base:q
MAINTAINER lamtv10@viettel.com.vn 

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE masakari

ENV RELEASE stable/queens
ENV SHARED_CONF_DIR /usr/share/docker


#Create $service user
RUN useradd --home-dir "/var/lib/$SERVICE" \
        --create-home \
        --system \
        --shell /bin/false \
        $SERVICE

#Create and set ownership of essential dirs
RUN mkdir -p /var/log/$SERVICE \
        && mkdir -p /etc/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/log/$SERVICE \
        && chown -R $SERVICE:$SERVICE /var/lib/$SERVICE \
        && chown -R $SERVICE:$SERVICE /etc/$SERVICE

RUN apt update \
	&& apt install -y git python-pip python-pymysql python-memcache crudini vim python-setuptools python3-setuptools \
	&& apt install -y  build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev \
	&& apt clean



RUN git clone https://github.com/openstack/masakari -b ${RELEASE} 

RUN pip install --upgrade pip 
RUN pip install wheel

RUN cd /masakari \
    && pip install -r requirements.txt . \
    && cp etc/masakari/* /etc/masakari/

#copy sudoer file
COPY masakari_sudoers /etc/sudoers.d/masakari_sudoers

#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

EXPOSE 15868

USER masakari

CMD ["start.sh"]














