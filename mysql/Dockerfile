ARG MYSQL_VERSION
FROM --platform=linux/x86_64 mysql:${MYSQL_VERSION}

# 日本語設定
RUN apt-get update && \
    apt-get install -y locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# MySQL設定ファイルをイメージ内にコピー
ADD ./mysql/conf/my.cnf /etc/mysql/my.cnf
ADD ./mysql/init/1_ddl.sql /docker-entrypoint-initdb.d/1_ddl.sql