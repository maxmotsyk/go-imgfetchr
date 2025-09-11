# 🐳 Docker Compose
.PHONY: up down logs ps

up:        ## Запустити всі сервіси (db, redis)
	docker compose up -d db redis

down:      ## Зупинити й видалити контейнери
	docker compose down

logs:      ## Подивитися логи Postgres
	docker compose logs -f db

ps:        ## Подивитися статус контейнерів
	docker compose ps

# 🗄️ Migrations
.PHONY: migrate-create migrate-up migrate-down migrate-force

migrate-create:  ## Створити нову міграцію (name=...)
	@if [ -z "$(name)" ]; then echo "❌ Вкажи ім'я: make migrate-create name=add_users"; exit 1; fi
	docker run --rm -v "$(PWD)/migrations":/migrations -w /migrations migrate/migrate:4 \
		create -ext sql -dir /migrations -seq $(name)

migrate-up:      ## Накатати всі нові міграції
	docker compose run --rm migrate up

migrate-down:    ## Відкотити одну міграцію
	docker compose run --rm migrate down 1

migrate-force:   ## Примусово виставити версію (використовуй обережно!)
	@if [ -z "$(version)" ]; then echo "❌ Вкажи версію: make migrate-force version=1"; exit 1; fi
	docker compose run --rm migrate force $(version)

# 🧹 Utility
.PHONY: restart
restart:   ## Перезапустити всі сервіси
	$(MAKE) down && $(MAKE) up