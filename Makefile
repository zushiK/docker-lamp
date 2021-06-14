.PHONY: help
help: ## ヘルプコマンド
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: command
command: ## make ec-command name=[コマンド名] : ECコンテナの中でphp artisan command:[コマンド名]を実行
	docker-compose exec apache php artisan command:$(name)

.PHONY: artisan
artisan: ## make ec-artisan name=[コマンド名] : ECコンテナの中でphp artisan [コマンド名]を実行
	docker-compose exec apache php artisan $(name)

.PHONY: initialize
initialize: ## ecサーバー 初期設定
	docker-compose exec apache php artisan migrate
	docker-compose exec apache php artisan db:seed --class InformationSeeder
	docker-compose exec apache php artisan command:adjust-category
	docker-compose exec apache php artisan db:seed --class InformationSeeder
	docker-compose exec apache php artisan db:seed --class MailTemplateSeed
	docker-compose exec apache php artisan command:get-exchange-usd-to-jpy