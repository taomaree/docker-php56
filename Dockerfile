# FROM phusion/baseimage:0.9.17
FROM ubuntu:14.04
MAINTAINER taomareee@gmail.com

ENV DEBIAN_FRONTEND=noninteractive \
	TZ='Asia/Shanghai' \
  APP_USER=app \
  APP_DATA_DIR=/var/www \
  APP_LOG_DIR=/var/log

ADD composer.phar /usr/local/bin/composer 

RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends \
 && echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \ 
 && sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
 && echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main"  > /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list \
 && apt-get update \
 && apt-get -y install  php5-fpm php5-cli php5-dev php5-gd php5-ldap php5-mcrypt php5-mysqlnd php5-xmlrpc php5-curl php5-geoip php5-pgsql php5-sqlite php-pear php-net-socket php-soap  php5-intl  libmagickwand-dev  php5-redis php5-mongo php5-memcached php5-apcu php5-imagick \
 && rm -rf /var/lib/apt/lists/* /tmp/* \
 && apt-get clean \
 && chmod 755 /usr/local/bin/composer 


EXPOSE 9000/tcp
VOLUME ["${APP_DATA_DIR}"]

CMD php5-fpm -F
