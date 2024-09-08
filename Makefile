# vim: set tabstop=8 softtabstop=8 noexpandtab:

.PHONY: help
help: ## Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
start: ## Starts Minecraft server
	@docker compose up -d
	@echo "Running Server on $(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}'):25565"
