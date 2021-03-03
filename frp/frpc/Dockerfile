FROM alpine:edge

LABEL maintainer="Tosone <i@tosone.cn>"

ARG FRP_VERSION=0.35.1

RUN sed -i 's/https:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.aliyun.com/g' /etc/apk/repositories && \
  apk add --no-cache pcre bash ca-certificates && \
  apk add --no-cache --virtual .build-deps wget tar && \
  wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
  tar zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
  mv frp_${FRP_VERSION}_linux_amd64/frpc /usr/bin && \
  apk del .build-deps && \
  rm -rf frp_${FRP_VERSION}_linux_amd64.tar.gz frp_${FRP_VERSION}_linux_amd64

WORKDIR /app

ADD frpc.ini .

CMD ["frpc", "-c", "frpc.ini"]
