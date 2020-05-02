FROM alpine:edge

LABEL maintainer="i@tosone.cn"

ARG FRP_VERSION=0.33.0

RUN sed -i 's/http:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.aliyun.com/g' /etc/apk/repositories && \
  apk add --no-cache pcre bash ca-certificates && \
  apk add --no-cache --virtual TMP wget tar && \
  wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
  tar zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
  mv frp_${FRP_VERSION}_linux_amd64/frps /usr/bin && \
  apk del TMP && \
  rm -rf frp_${FRP_VERSION}_linux_amd64.tar.gz frp_${FRP_VERSION}_linux_amd64

WORKDIR /app

ADD frps.ini .

CMD ["frps", "-c", "frps.ini"]
