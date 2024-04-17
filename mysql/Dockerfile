ARG MYSQL_VERSION
FROM mysql:${MYSQL_VERSION}-debian

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 467B942D3A79BD29
RUN apt-get update
RUN apt-get -y install locales-all

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# MySQL設定ファイルをイメージ内にコピー
ADD ./mysql/conf/my.cnf /etc/mysql/my.cnf