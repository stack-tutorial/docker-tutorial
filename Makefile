include .env
export $(shell sed 's/=.*//' .env)

export COMPOSE_IGNORE_ORPHANS=True # ignore others container

compose_version = 1.25.0

all = gitea gogs mongo redis mysql influxdb netdata shadowsocks

.PHONY: install-docker
install-docker:
	curl -fsSL https://get.docker.com | sh
	sudo usermod -aG docker $(USER)
	sudo curl -L https://github.com/docker/compose/releases/download/$(compose_version)/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
	sudo chmod +x /usr/bin/docker-compose
	docker network create webproxy

.PHONY: check-dir
check-dir:
	$(foreach dir, $(all), $(shell mkdir -p $(VOLUME_PREFIX)/$(dir)))

.PHONY: shadowsocks-proxy
shadowsocks-proxy:
	shadowsocks-proxy/gen.sh >> $@/modules-enabled/shadowsocks.conf
	docker-compose up --force-recreate -d --build $@
	$(RM) $@/modules-enabled/shadowsocks.conf

.PHONY: frps frpc
frps frpc:
	docker-compose up --force-recreate -d $@

.PHONY: $(all)
$(all): check-dir
	docker-compose up --force-recreate -d $@

.PHONY: postgres
postgres:
	cd $@ && sh gen.sh
	if [ ! -d $(VOLUME_PREFIX)/$@ ]; then mkdir -p $(VOLUME_PREFIX)/$@; fi
	if [ ! -d ${VOLUME_PREFIX}/key ]; then sudo mkdir -p ${VOLUME_PREFIX}/key; fi
	sudo cp -r $@ ${VOLUME_PREFIX}/key
	sudo chmod 640 ${VOLUME_PREFIX}/key/$@/server.key && sudo chown 0:70 ${VOLUME_PREFIX}/key/$@/server.key
	docker-compose up --force-recreate -d $@

.PHONY: traefik
traefik:
	mkdir -p $(VOLUME_PREFIX)/$@
	touch $(VOLUME_PREFIX)/$@/acme.json
	sudo chmod 600 $(VOLUME_PREFIX)/$@/acme.json
	docker-compose -f docker-compose-$@.yml up --force-recreate -d $@

.PHONY: upgrade
upgrade:
	docker-compose pull $(all)
	docker-compose -f docker-compose-traefik.yml pull traefik
