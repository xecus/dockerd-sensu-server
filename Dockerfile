FROM ubuntu:14.04
MAINTAINER Hiroyuki.Ootaguro

RUN useradd -m -d /home/docker -s /bin/bash docker
RUN echo "docker:docker" | chpasswd
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:en
ENV LC_ALL ja_JP.UTF-8

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y autoclean
RUN apt-get -y clean

RUN apt-get -y install wget apt-transport-https
RUN wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add -
RUN echo "deb     https://sensu.global.ssl.fastly.net/apt trusty main" | tee /etc/apt/sources.list.d/sensu.list
RUN apt-get update
RUN apt-get -y install sensu uchiwa

COPY config.json /etc/sensu/config.json
COPY uchiwa.json /etc/sensu/uchiwa.json

COPY startup.sh /startup.sh
RUN chmod 755 /startup.sh

CMD "/startup.sh"
