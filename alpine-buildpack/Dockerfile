FROM alpine:edge

LABEL maintainer="i@tosone.cn"

RUN sed -i "s/http:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.aliyun.com/g" /etc/apk/repositories

RUN apk add --no-cache build-base mdocml-apropos \
  coreutils ca-certificates autoconf automake libtool cmake \
  bc tree vim git fish dialog less tzdata

RUN sed -i "s/bin\/ash/usr\/bin\/fish/" /etc/passwd

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV SHELL /usr/bin/fish

WORKDIR /app

CMD /usr/bin/fish
