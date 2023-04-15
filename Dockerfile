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
  apt-get install -y wget cpio rsync

WORKDIR /opt/tpi
