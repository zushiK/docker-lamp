# laravel向けDocker環境

## 既存プロジェクト環境構築の流れ

**プロジェクトのリポジトリのクローン**

`$ git clone https://github.com/laravel/laravel.git`

**laravelのenvファイル作成**

``` .envの中身を変更
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=db1
DB_USERNAME=root
DB_PASSWORD=root
```

**dockerのenvファイルをコピー**

`$ cp .env.copy .env`

**APP_PATHの入力(フルパスで入れてください。)**

`APP_PATH=/Users/zushi/docker/temp-php-project`

**コンテナ立ち上げと初期化**

`$ make init`