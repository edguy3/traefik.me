

ps:
	docker compose ps

up: update-certs
	docker compose up -d && docker compose logs -f

update-certs:
	docker compose up reverse-proxy-https-helper

down:
	docker compose down
