FROM debian:buster

LABEL maintainer="i@tosone.cn"

RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
  sed -i "s/security.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  squid apache2-utils && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY entry.sh .
COPY squid.conf /etc/squid/squid.conf

EXPOSE 3128

ENTRYPOINT /app/entry.sh
