FROM nodesource/jessie:4.6.0
# PL: Why 4.6.0 vs latest? Because the Wink module doesn't work on Node 6.x :(
MAINTAINER Patrick Lightbody <patrick@lightbody.net>

##################################################
# Set environment variables                      #
##################################################

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

##################################################
# Install tools                                  #
##################################################

RUN apt-get update
RUN apt-get install -y apt-utils 
RUN apt-get install -y apt-transport-https
RUN apt-get install -y locales
RUN apt-get install -y curl wget git python build-essential make g++ libavahi-compat-libdnssd-dev libkrb5-dev vim net-tools nano
RUN alias ll='ls -alG'

##################################################
# Install homebridge                             #
##################################################

RUN npm install -g homebridge --unsafe-perm

# depending on your config.json you have to add your modules here!
# PL Change: just picking the modules I need -- faster that putting in package.json
RUN npm install -g homebridge-philipshue --unsafe-perm
RUN npm install -g homebridge-platform-wemo --unsafe-perm
RUN npm install -g homebridge-wink --unsafe-perm

##################################################
# Start                                          #
##################################################

USER root
RUN mkdir -p /var/run/dbus

# ADD config-sample/package.json /root/.homebridge/package.json
ADD image/run.sh /root/run.sh

EXPOSE 5353 51826
CMD ["/root/run.sh"]
[~/homebridge-synology-docker]$ 
