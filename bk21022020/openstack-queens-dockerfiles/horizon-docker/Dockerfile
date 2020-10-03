FROM base:q
MAINTAINER lamtv@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE horizon
ENV SHARED_CONF_DIR /usr/share/docker

#Clear cache apt
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get update -y

#install horizon
RUN apt-get update && apt-get -y install --no-install-recommends openstack-dashboard \
  && apt-get clean

#install lbaasv2 octavia dashboard
#RUN apt-get update && apt-get -y install --no-install-recommends python-setuptools
#RUN git clone https://github.com/openstack/octavia-dashboard
#RUN cd /octavia-dashboard && git checkout -b stable/queens \
#  && pip install -r requirements.txt . \
#  && cp /usr/local/lib/python2.7/dist-packages/octavia_dashboard/enabled/_1482_project_load_balancer_panel.py /usr/share/openstack-dashboard/openstack_dashboard/local/enabled/

RUN cd /usr/share/openstack-dashboard \
  && python manage.py collectstatic --noinput \
  && python manage.py compress

#copy script
COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

#config apache2
RUN a2dissite 000-default.conf \
  && echo > /etc/apache2/ports.conf \
  && echo ServerName localhost >> /etc/apache2/apache2.conf

VOLUME ["/var/log/apache2"]

EXPOSE 80 443

USER root

CMD ["start.sh"]
