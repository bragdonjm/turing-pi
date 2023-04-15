FROM debian:stable-slim as SETUP

LABEL description="Build tools for the turing pi 2 BMC firmware."
LABEL org.opencontainers.image.authors="bragdonjm@gmail.com"

RUN mkdir -p /opt/tpi


RUN                   \
  apt update &&       \
  apt upgrade -y &&   \
  apt install -y      \
  bc build-essential bzr cvs ecj file flex git-core gawk lib32stdc++6 lib32z1 lib32z1-dev libncurses5-dev libncurses-dev \
  libssl-dev libstdc++6 libxml-parser-perl mercurial mkbootimg subversion quilt u-boot-tools unzip xsltproc zlib1g-dev -y
     
RUN \
  apt-get install -y cpio rsync sudo vim-common wget 

# Run the container as the current user to solve for any github dubious warnings
# This will setup matching GID/UID so the docker executor will run as you
# and you can execute sudo. 

ARG UID
ARG USER
ARG SID

RUN adduser $USER
RUN usermod -a -G sudo -u $UID $USER
COPY sudoers.sh /tmp/sudoers.sh
RUN /tmp/sudoers.sh $USER

WORKDIR /opt/tpi
