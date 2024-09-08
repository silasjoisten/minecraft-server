# vim: set tabstop=8 softtabstop=8 noexpandtab:

.PHONY: help
help: ## Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
start: ## Starts the Minecraft server
	@docker compose up -d
	@echo "Running Server on $(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}'):25565"

.PHONY: stop
stop: ## Stops the Minecraft server
	@docker compose down

.PHONY: backup
backup: export BACKUP_FILENAME=`TZ='Europe/Berlin' date +'%Y-%m-%d_%H-%M-%S'`
backup: stop ## Backup world data and configurations
	@tar -zcvf backup/${BACKUP_FILENAME}_world.tar.gz data/world/
	@tar -zcvf backup/${BACKUP_FILENAME}_config.tar.gz data/banned-ips.json data/banned-players.json data/ops.json data/server.properties data/whitelist.json

.PHONY: tunnel
tunnel: ## Tunnel the Minecraft server to the internet
	@ngrok tcp 25565
