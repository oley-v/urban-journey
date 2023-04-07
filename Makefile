# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(TAG) .

run: ## Run container on port configured in `config.env`
	docker run -d --env-file=./config.env -p=$(PORT):22 --name="$(NAME)" $(TAG)
	docker ps -n 1


up: build run ## Build and Run container with `config.env` (Alias)

stop: ## Stop and remove a running container
	docker stop $(NAME); docker rm $(NAME)
