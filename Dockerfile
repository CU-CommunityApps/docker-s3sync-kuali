# Pull base image.
FROM dtr.cucloud.net/cs/s3sync

USER root

RUN \
  apt-get update && \
  apt-get install -y tomcat7 multitail && \
  rm -rf /var/lib/apt/lists/* 

# set the running user to deamon, dont run as root
USER tomcat7

# run the sync app
CMD /opt/sync.rb
