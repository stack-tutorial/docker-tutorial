app_name                := alpine-buildpack
docker_name             := $(app_name)
docker_tag              := dev
docker_container        := $(app_name)

.PHONY: upgrade
upgrade:
	docker pull alpine:edge

.PHONY: build
build:
	docker-compose build $(docker_name)

.PHONY: run
run:
	docker-compose up --force-recreate -d

.PHONY: exec
exec:
	docker-compose exec -it $(docker_container)

.PHONY: exec-now
exec-now:
	docker-compose run --rm $(docker_container)
