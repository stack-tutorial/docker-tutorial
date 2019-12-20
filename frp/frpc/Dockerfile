FROM alpine:edge

ARG FRP_VERSION=0.30.0

RUN sed -i 's/http:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.aliyun.com/g' /etc/apk/repositories 

RUN apk add --no-cache pcre bash ca-certificates && \
  apk add --no-cache --virtual TMP wget tar && \
  wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
  tar zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
  mv frp_${FRP_VERSION}_linux_amd64/frpc /usr/bin && \
  apk --no-cache del --virtual TMP && \
  rm -rf frp_${FRP_VERSION}_linux_amd64.tar.gz frp_${FRP_VERSION}_linux_amd64

VOLUME /app

ADD frpc.ini /app/frpc.ini

CMD ["frpc", "-c", "/app/frpc.ini"]
