# LAMP環境 Docker

## 環境構築の流れ

```
$ cp .env.copy .env

# アプリケーションのフルパスを埋める
# 各種バージョンを決める

$ make up
```

## プロジェクトのデフォルト設定値

### Apache
localhost

### PHPMYADMIN
localhost:8081

### Mail Catcher
localhost:1080
### Mysql
```
DB_PORT=3306
DATABASE_NAME=db1
DB_USERNAME=root
DB_PASSWORD=root
```