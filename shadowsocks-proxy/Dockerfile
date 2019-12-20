FROM nginx:alpine

ADD $PWD/modules-enabled/*.conf /etc/nginx/modules-enabled/
ADD $PWD/nginx.conf /etc/nginx/

EXPOSE ${SHADOWSOCKS_PORT}
