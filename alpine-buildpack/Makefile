app_name = alpine-buildpack

.PHONY: upgrade
upgrade:
	docker pull alpine:edge

.PHONY: build
build:
	docker-compose build $(app_name)

.PHONY: run
run:
	docker-compose up --force-recreate -d

.PHONY: exec
exec:
	docker-compose exec -it $(app_name)

.PHONY: exec-now
exec-now:
	docker-compose run --rm $(app_name)
