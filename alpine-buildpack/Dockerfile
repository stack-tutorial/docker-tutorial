FROM alpine:edge

RUN sed -i 's/http:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && apk upgrade \
  && apk add --no-cache build-base mdocml-apropos \
  coreutils ca-certificates autoconf automake libtool \
  bc tree vim git fish dialog less tzdata

RUN sed -i "s/bin\/ash/usr\/bin\/fish/" /etc/passwd

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV SHELL /usr/bin/fish

CMD ["/usr/bin/fish"]
