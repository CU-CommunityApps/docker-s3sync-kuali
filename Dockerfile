# Pull base image.
FROM dtr.cucloud.net/cs/s3sync

USER root

RUN groupadd -g 7070 tcadm
RUN useradd -u 105 -g 7070 tomcat7
COPY sync.rb /opt/sync.rb
RUN chown tomcat7:tcadm /opt/sync.rb &&\
   chmod 775 /opt/sync.rb


# set the running user to deamon, dont run as root
USER tomcat7

# run the sync app
CMD /opt/sync.rb
