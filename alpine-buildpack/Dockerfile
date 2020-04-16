FROM alpine:edge

LABEL maintainer="Tosone <i@tosone.cn>"

RUN sed -i "s/http:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.aliyun.com/g" /etc/apk/repositories && \
  apk add --no-cache build-base mdocml-apropos \
  coreutils ca-certificates autoconf automake libtool cmake \
  bc tree vim git fish dialog less tzdata && \
  sed -i "s/bin\/ash/usr\/bin\/fish/" /etc/passwd && \
  rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV SHELL /usr/bin/fish

CMD /usr/bin/fish
