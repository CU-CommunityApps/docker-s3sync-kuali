# Pull base image.
FROM dtr.cucloud.net/cs/s3sync

USER root

RUN useradd -u 105 tomcat7

# set the running user to deamon, dont run as root
USER tomcat7

# run the sync app
CMD /opt/sync.rb
