#!/bin/sh

openssl req -new -text -newkey rsa:4096 -passout pass:${SECRETPERSONAL} -subj /CN=localhost -keyout privkey.pem -out server.req
openssl rsa -in privkey.pem -passin pass:${SECRETPERSONAL} -out server.key
openssl req -x509 -in server.req -text -key server.key -out server.crt
