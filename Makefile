# 🐳 Docker Compose
.PHONY: up down logs ps

up:        ## Запустити Postgres
	docker compose up -d db

down:      ## Зупинити й видалити контейнери
	docker compose down

logs:      ## Подивитися логи Postgres
	docker compose logs -f db

ps:        ## Подивитися статус контейнерів
	docker compose ps

# 🗄️ Migrations
.PHONY: migrate-create migrate-up migrate-down migrate-force migrate-version

migrate-create:  ## Створити нову міграцію (name=...)
	@if [ -z "$(name)" ]; then echo "❌ Вкажи ім'я: make migrate-create name=add_users"; exit 1; fi
	docker run --rm -v "$(PWD)/migrations":/migrations -w /migrations migrate/migrate:4 \
		create -ext sql -dir /migrations -seq $(name)

migrate-up:      ## Накатати всі нові міграції
	docker compose run --rm migrate -verbose up

migrate-down:    ## Відкотити одну міграцію
	docker compose run --rm migrate -verbose down 1

migrate-force:   ## Примусово виставити версію (обережно!)
	@if [ -z "$(version)" ]; then echo "❌ Вкажи версію: make migrate-force version=1"; exit 1; fi
	docker compose run --rm migrate force $(version)

migrate-version: ## Показати поточну версію
	docker compose run --rm migrate version