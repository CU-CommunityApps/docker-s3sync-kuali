# Pull base image.
FROM 078742956215.dkr.ecr.us-east-1.amazonaws.com/kuali/base

USER root
RUN mkdir /sync
# Install python and pip
RUN \
  apt-get update && \
  apt-get install -y  python python-pip jq && \
  rm -rf /var/lib/apt/lists/*

# Install AWS CLI tools
RUN pip install awscli

RUN groupadd -g 7070 tcadm
RUN useradd -u 105 -g 7070 tomcat7
COPY sync.rb /opt/sync.rb
RUN chown tomcat7:tcadm /opt/sync.rb &&\
   chmod 775 /opt/sync.rb


# set the running user to deamon, dont run as root
USER tomcat7

# run the sync app
CMD /opt/sync.rb
