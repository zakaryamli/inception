WP_DATA  = "$(HOME)/data/wordpress"
DB_DATA  = "$(HOME)/data/mariadb"

COMPOSE  = docker-compose -f ./srcs/docker-compose.yml

all: up

up: build
	@mkdir -p $(WP_DATA) $(DB_DATA)
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

stop:
	@$(COMPOSE) stop

start:
	@$(COMPOSE) start

build:
	@$(COMPOSE) build

rebuild:
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

