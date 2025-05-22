COMPOSE = docker compose

build: update-env db
	$(COMPOSE) build base
	$(COMPOSE) build stream

update-env:
	./scripts/config.sh

db:
	make -C ./scripts

push:
	$(COMPOSE) push stream
