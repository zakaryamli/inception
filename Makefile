WP_DATA = $(HOME)/data/wordpress
DB_DATA = $(HOME)/data/mariadb
PO_DATA = $(HOME)/data/portainer

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	@mkdir -p $(PO_DATA)WP_DATA = $(HOME)/data/wordpress
DB_DATA = $(HOME)/data/mariadb
PO_DATA = $(HOME)/data/portainer

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	@mkdir -p $(PO_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

build:
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	@docker-compose -f ./srcs/docker-compose.yml down --rmi all --remove-orphans
	@docker network rm inception 2>/dev/null || true

fclean: clean
	@sudo rm -rf $(WP_DATA) $(DB_DATA) $(PO_DATA)2>/dev/null || true

re: clean up

purge: fclean
	@docker system prune -a --volumes -f
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

build:
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	@docker-compose -f ./srcs/docker-compose.yml down --rmi all --remove-orphans
	@docker network rm inception 2>/dev/null || true

fclean: clean
	@sudo rm -rf $(WP_DATA) $(DB_DATA) $(PO_DATA)2>/dev/null || true

re: clean up

purge: fclean
	@docker system prune -a --volumes -f
