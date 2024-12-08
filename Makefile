.PHONY: all help start

all: help

bash: ## Bash into the koeldev container
	docker exec --user www-data -it koeldev bash

build: ## Builds using docker-compose.mysql.yml
	docker-compose -f docker-compose.mysql.yml build

build-all-arch-docker-images: ## Builds the production Docker image for all supported processor architectures
	docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64 . --file Dockerfile --tag phanan/koel-dev:latest

init: ## Build the docker image and run init command
	$(MAKE) start
	$(MAKE) koel-init
	$(MAKE) sync-music

koel-init: ## Create the APP_KEY for the docker-compose.mysql.yml stack
	docker exec -it koeldev php artisan koel:init --no-assets

koel-init-assets: ## Create the APP_KEY for the docker-compose.mysql.yml stack
	docker exec -it koeldev php artisan koel:init

sync-music: ## Sync music from the /music volume with the database
	docker exec --user www-data -it koeldev php artisan koel:scan -v

sync-podcast: ## Sync podcast from the /podcast volume with the database
	docker exec --user www-data -it koeldev php artisan koel:podcasts:sync -v

setup-storage: ## Setup the storage folder
	docker exec --user www-data -it koeldev php artisan koel:storage

search-import: ## Import search index
	docker exec --user www-data -it koeldev php artisan koel:search:import

clear-cache: ## Clear caches that sometimes cause error 500
	docker exec -it koeldev php artisan cache:clear

see-logs: ## Tail -f laravel logs
	docker exec -it koeldev tail -f storage/logs/laravel.log

start: ## Build and start the docker-compose.mysql.yml stack
	# Create the .env files first, otherwise docker-compose is not happy
	docker-compose -f docker-compose.mysql.yml up -d --build
	@echo "Go to http://localhost"

stop: ## Stop the docker-compose.mysql.yml stack
	docker-compose -f docker-compose.mysql.yml down
	@echo "Services stopped"

up: ## Start the docker-compose.mysql.yml stack
	docker-compose -f docker-compose.mysql.yml up -d
	make sync-music
	make sync-podcast
	make search-import
	make koel-init
	@echo "Go to http://localhost"

down: ## Stop the docker-compose.mysql.yml stack
	docker-compose -f docker-compose.mysql.yml down
	@echo "Services stopped"

restart: ## Restart the docker-compose.mysql.yml stack
	$(MAKE) stop
	$(MAKE) start

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
