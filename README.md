# Minecraft Server

## Installation

1. Install [Docker](https://docs.docker.com/get-docker/)
2. Install [Docker Compose](https://docs.docker.com/compose/install/)
3. Clone the repository
4. Run `make start` to start the server
5. Run `make stop` to stop the server
6. Run `make backup` to backup your world data and the server configs

You can access the server on port `25565`

## Usage

### With docker compose

you can use the image directly with `docker compose`:

```yaml
services:
  minecraft-server:
    image: ghcr.io/silasjoisten/minecraft-server:latest
    environment:
      - EULA=true
      - MEMORY=2G
    ports:
      - "25565:25565"
    volumes:
      - ./data:/opt/minecraft
    stdin_open: true
    tty: true
    restart: unless-stopped
```

### With Docker

You can also use the image directly with `docker`:

```bash
docker run -d \
  -e EULA=true \
  -e MEMORY=4G \
  -p 25565:25565 \
  -v $(pwd)/data:/opt/minecraft \
  --name minecraft-server \
  --restart unless-stopped \
  ghcr.io/silasjoisten/minecraft-server:latest
```