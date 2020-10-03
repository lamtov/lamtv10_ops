FROM centos:7
VOLUME /root/lamtv10
#RUN mkdir /root/lamtv10/
#
WORKDIR /root/lamtv10
RUN pwd
COPY lamtv10.log /root/lamtv10.log
COPY lamtv10.log /root/lamtv10/lamtv10.log
RUN cat /root/lamtv10.log
CMD tail -f /root/lamtv10.log
