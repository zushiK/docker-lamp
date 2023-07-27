.PHONY: help
help: ## ヘルプコマンド
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: up
up: ## コンテナ起動
	docker compose up -d

.PHONY: build
build: ## コンテナ再生成
	docker compose build --no-cache --force-rm

.PHONY: laravel-install
laravel-install: ## コンテナ内に直接laravelインストール(最新版)
	docker compose exec web composer create-project --prefer-dist laravel/laravel .

.PHONY: init
init: ## コンテナ初期設定(既存プロジェクトに使う場合)
	docker compose up -d --build
	docker compose exec web composer install
	docker compose exec web php artisan key:generate
	docker compose exec web php artisan storage:link
	docker compose exec web chmod -R 777 storage bootstrap/cache
	@make fresh
	@make npm-install
	@make npm-dev

.PHONY: remake
remake: ## コンテナ削除と初期設定
	@make destroy
	@make init

.PHONY: stop
stop: ## 
	docker compose stop

.PHONY: down
down: ## 
	docker compose down --remove-orphans

.PHONY: restart
restart: ## 
	@make down
	@make up

.PHONY: destroy
destroy: ## 
	docker compose down --rmi all --volumes --remove-orphans

.PHONY: destroy-volumes
destroy-volumes: ## 
	docker compose down --volumes --remove-orphans

.PHONY: ps
ps: ## 
	docker compose ps

.PHONY: logs
logs: ## 
	docker compose logs

.PHONY: logs-watch
logs-watch: ## 
	docker compose logs --follow

.PHONY: log-web
log-web: ## 
	docker compose logs web

.PHONY: log-web-watch
log-web-watch: ## 
	docker compose logs --follow web

.PHONY: log-db
log-db: ## 
	docker compose logs db

.PHONY: log-db-watch
log-db-watch: ## 
	docker compose logs --follow db

.PHONY: bash
bash: ## 
	docker compose exec apache bash

.PHONY: web
web: ## 
	docker compose exec web bash

.PHONY: migrate
migrate: ## 
	docker compose exec web php artisan migrate

.PHONY: fresh
fresh: ## 
	docker compose exec web php artisan migrate:fresh --seed

.PHONY: seed
seed: ## 
	docker compose exec web php artisan db:seed

.PHONY: dacapo
dacapo: ## 
	docker compose exec web php artisan dacapo

.PHONY: rollback-test
rollback-test: ## 
	docker compose exec web php artisan migrate:fresh
	docker compose exec web php artisan migrate:refresh

.PHONY: tinker
tinker: ## 
	docker compose exec web php artisan tinker

.PHONY: test
test: ## 
	docker compose exec web php artisan test

.PHONY: optimize
optimize: ## 
	docker compose exec web php artisan optimize

.PHONY: optimize-clear
optimize-clear: ## 
	docker compose exec web php artisan optimize:clear

.PHONY: cache
cache: ## 
	docker compose exec web composer dump-autoload -o
	@make optimize
	docker compose exec web php artisan event:cache
	docker compose exec web php artisan view:cache

.PHONY: cache-clear
cache-clear: ## 
	docker compose exec web composer clear-cache
	@make optimize-clear
	docker compose exec web php artisan event:clear

.PHONY: npm
npm: ## 
	@make npm-install

.PHONY: npm-install
npm-install: ## 
	docker compose exec web npm install

.PHONY: npm-dev
npm-dev: ## 
	docker compose exec web npm run dev

.PHONY: npm-watch
npm-watch: ## 
	docker compose exec web npm run watch

.PHONY: npm-watch-poll
npm-watch-poll: ## 
	docker compose exec web npm run watch-poll

.PHONY: npm-hot
npm-hot: ## 
	docker compose exec web npm run hot

.PHONY: yarn
yarn: ## 
	docker compose exec web yarn

.PHONY: yarn-install
yarn-install: ## 
	@make yarn

.PHONY: yarn-dev
yarn-dev: ## 
	docker compose exec web yarn dev

.PHONY: yarn-watch
yarn-watch: ## 
	docker compose exec web yarn watch

.PHONY: yarn-watch-poll
yarn-watch-poll: ## 
	docker compose exec web yarn watch-poll

.PHONY: yarn-hot
yarn-hot: ## 
	docker compose exec web yarn hot

.PHONY: mysql
mysql: ## 
	docker compose exec mysql bash

.PHONY: sql
sql: ## 
	docker compose exec mysql bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'

.PHONY: redis
redis: ## 
	docker compose exec redis redis-cli

.PHONY: ide-helper
ide-helper: ## 
	docker compose exec web php artisan clear-compiled
	docker compose exec web php artisan ide-helper:generate
	docker compose exec web php artisan ide-helper:meta
	docker compose exec web php artisan ide-helper:models --nowrite