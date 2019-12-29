include .env
export $(shell sed 's/=.*//' .env)

export COMPOSE_IGNORE_ORPHANS=True # ignore others container

compose_version = 1.25.0

all = gitea gogs mongo redis mysql influxdb filebrowser jupyter

run: ensure-dir traefik frps frpc postgres $(all)

.PHONY: install-docker
install-docker:
	curl -fsSL https://get.docker.com | sh
	sudo usermod -aG docker $(USER)
	sudo curl -L https://github.com/docker/compose/releases/download/$(compose_version)/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
	sudo chmod +x /usr/bin/docker-compose
	docker network create $(DOCKER_NETWORK)

.PHONY: ensure-dir
ensure-dir:
	$(foreach dir, $(all), $(shell if [ ! -d $(VOLUME_PREFIX)/$(dir) ]; then mkdir -p $(VOLUME_PREFIX)/$(dir); fi))

.PHONY: $(all) frps frpc netdata shadowsocks httpbin squid
$(all) frps frpc netdata shadowsocks httpbin proxy phpmyadmin:
	docker-compose up --force-recreate -d $@

.PHONY: shadowsocks-proxy
shadowsocks-proxy:
	cd $@ && sh gen.sh > modules-enabled/shadowsocks.conf
	docker-compose up --force-recreate -d --build $@
	$(RM) $@/modules-enabled/shadowsocks.conf

.PHONY: postgres
postgres: ensure-dir
	cd $@ && sh gen.sh
	if [ ! -d $(VOLUME_PREFIX)/$@ ]; then mkdir -p $(VOLUME_PREFIX)/$@; fi
	if [ ! -d ${VOLUME_PREFIX}/key ]; then mkdir -p ${VOLUME_PREFIX}/key; fi
	sudo cp -r $@ ${VOLUME_PREFIX}/key
	cd ${VOLUME_PREFIX}/key/$@ && sudo chmod 640 server.key && sudo chown 0:70 server.key
	docker-compose up --force-recreate -d $@

.PHONY: traefik
traefik:
	if [ ! -d $(VOLUME_PREFIX)/$@ ]; then mkdir -p $(VOLUME_PREFIX)/$@; fi
	if [ ! -f $(VOLUME_PREFIX)/$@/acme.json ]; then touch $(VOLUME_PREFIX)/$@/acme.json; fi
	sudo chmod 600 $(VOLUME_PREFIX)/$@/acme.json
	docker-compose -f docker-compose-$@.yml up --force-recreate -d $@

.PHONY: upgrade
upgrade:
	docker-compose pull $(all)
	docker-compose -f docker-compose-traefik.yml pull traefik
