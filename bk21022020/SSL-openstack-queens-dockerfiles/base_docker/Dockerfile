FROM ubuntu:16.04
MAINTAINER lamtv@viettel.com.vn


LABEL openstack_version="qns"
ENV DEBIAN_FRONTEND noninteractive
ENV SHARED_CONF_DIR /usr/share/docker
RUN apt-get -y update && apt-get -y dist-upgrade
RUN apt-get install -y --no-install-recommends software-properties-common

RUN add-apt-repository cloud-archive:queens

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get -y install --no-install-recommends \
        apt-utils \
        curl \
        gawk \
        iproute2 \
        kmod \
        lvm2 \
        netbase \
        open-iscsi \
        python \
        python-memcache \
        git \
        python-pip \
        python-pymysql \
        sudo \
        nano \
        tgt \
    && apt-get clean




RUN apt-get -y update && apt-get -y dist-upgrade
