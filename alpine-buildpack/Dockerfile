FROM alpine:edge

LABEL maintainer="Tosone <i@tosone.cn>"

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
  apk add --no-cache bash build-base \
  coreutils ca-certificates autoconf automake libtool cmake curl \
  tree vim git dialog less tzdata ncurses bind-tools && \
  rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY .bashrc /root

WORKDIR /app

CMD /usr/bash
