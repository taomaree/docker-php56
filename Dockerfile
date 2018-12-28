# FROM phusion/baseimage:0.9.17
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
  TZ='Asia/Shanghai' \
  LC_ALL=C.UTF-8 \
  APP_USER=app \
  APP_DATA_DIR=/app/wwwroot \
  APP_LOG_DIR=/var/log

RUN apt-get update ; \
  apt-get install -y --no-install-recommends curl wget ca-certificates software-properties-common ;\
  add-apt-repository -y ppa:ondrej/php ; apt-get update ; \
  apt-get install -y --no-install-recommends vim-tiny composer pkg-config php5.6-fpm php5.6-dev php-pear php5.6-common \
    php5.6-bcmath php5.6-bz2 php5.6-curl php5.6-enchant \
    php5.6-gd php5.6-imap php5.6-intl php5.6-json php5.6-ldap php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-opcache \
    php5.6-pspell php5.6-readline php5.6-recode php5.6-soap php5.6-sqlite3 php5.6-tidy php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-zip \
    php5.6-pgsql php-imagick php-mongo php-mongodb php-memcache php-memcached php-apcu php-geoip php-net-socket librabbitmq-dev \
 && echo -n |pecl install -f amqp-1.9.3 protobuf \
 && rm -rf /var/lib/apt/lists/* /tmp/* \
 && apt-get clean 

EXPOSE 9000/tcp
VOLUME ["${APP_DATA_DIR}"]

CMD php-fpm5.6 -F
