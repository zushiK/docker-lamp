# laravel向けDocker環境

## 既存プロジェクト環境構築の流れ

**プロジェクトのリポジトリのクローン**

`$ https://github.com/laravel/laravel.git`

**envファイルをコピー**

`$ cp .env.copy .env`

**APP_PATHの入力(フルパスで入れてください。)**
`APP_PATH=/Users/zushi/docker/temp-php-project`

**コンテナ立ち上げと初期化**

`$ make init`