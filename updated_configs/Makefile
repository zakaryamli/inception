all: up
WP_DATA = /zyamli/data/wordpress
DB_DATA = /zyamli/data/database

create_dirs:
	@sudo mkdir -p $(WP_DATA)
	@sudo mkdir -p $(DB_DATA)
	@sudo chown -R $$(whoami):$$(whoami) /zyamli

COMPOSE  = docker compose -f ./srcs/docker-compose.yml


up:
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

stop:
	@$(COMPOSE) stop

start:
	@$(COMPOSE) start

build:
	@$(COMPOSE) build

rebuild: create_dirs
	@$(COMPOSE) build --no-cache
	@$(COMPOSE) up -d

logs:
	@$(COMPOSE) logs -f

exec:
	@docker exec -it wordpress bash

env-check:
	@echo "ENV File Preview:"
	@cat .env | grep -v '^#'

clean:
	@$(COMPOSE) down --rmi all --remove-orphans
	@docker network rm inception 2>/dev/null || true

fclean: clean
	@sudo rm -rf $(WP_DATA) $(DB_DATA) 2>/dev/null || true

re: fclean up

purge: fclean
	@docker system prune -a --volumes -f

ls:
	@docker ps
