#!/bin/sh

set -xe

if [ -z "${USERNAME}" ]; then
  echo "You have to specify the -e USERNAME=... argument"
  exit
fi

if [ -z "${PASSWORD}" ]; then
  echo "You have to specify the -e PASSWORD=... argument"
  exit
fi

htpasswd -cb /etc/squid/passwd "${USERNAME}" "${PASSWORD}"

exec $(which squid) -NYCd 1
