FROM debian:buster

LABEL maintainer="Tosone <i@tosone.cn>"

RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
  sed -i "s/security.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
  apt-get update && apt-get install -y build-essential \
  coreutils ca-certificates autoconf automake libtool cmake curl \
  tree vim git dialog less tzdata patch unzip xz-utils zlib1g-dev && \
  rm -rf /var/lib/apt/lists/* && \
  rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY .bashrc /root

WORKDIR /app

CMD /usr/bash
