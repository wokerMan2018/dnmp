#!/bin/sh

echo
echo "============================================"
echo "Install extensions from   : ${MORE_EXTENSION_INSTALLER}"
echo "PHP version               : ${PHP_VERSION}"
echo "Extra Extensions          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation     : ${MC}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo


if [ -z "${EXTENSIONS##*,mcrypt,*}" ]; then
    echo "---------- mcrypt was REMOVED from PHP 7.2.0 ----------"
fi


if [ -z "${EXTENSIONS##*,mysql,*}" ]; then
    echo "---------- mysql was REMOVED from PHP 7.0.0 ----------"
fi

if [ -z "${EXTENSIONS##*,event,*}" ]; then
    echo "---------- Install event ----------"
    mkdir event \
    && tar -xf event-2.5.3.tgz -C event --strip-components=1 \
    && ( cd event && phpize && ./configure  && make ${MC} && make install ) \
    && docker-php-ext-enable --ini-name event.ini event
fi

if [ -z "${EXTENSIONS##*,sodium,*}" ]; then
    echo "---------- Install sodium ----------"
    echo "Sodium is bundled with PHP from PHP 7.2.0 "
fi

if [ -z "${EXTENSIONS##*,mongodb,*}" ]; then
    echo "---------- Install mongodb ----------"
    mkdir mongodb \
    && tar -xf mongodb-1.5.5.tgz -C mongodb --strip-components=1 \
    && ( cd mongodb && phpize && ./configure  && make ${MC} && make install ) \
    && docker-php-ext-enable  mongodb
fi

if [ -z "${EXTENSIONS##*,yaf,*}" ]; then
    echo "---------- Install yaf ----------"
    pecl install yaf
    docker-php-ext-enable yaf
fi

if [ -z "${EXTENSIONS##*,yac,*}" ]; then
    echo "---------- Install yac ----------"
    printf "\n" | pecl install yac-2.0.2
    docker-php-ext-enable yac
fi

if [ -z "${EXTENSIONS##*,yaconf,*}" ]; then
    echo "---------- Install yaconf ----------"
    printf "\n" | pecl install yaconf
    docker-php-ext-enable yaconf
fi

if [ -z "${EXTENSIONS##*,amqp,*}" ]; then
    echo "---------- Install amqp ----------"
    apk add --no-cache rabbitmq-c-dev
    cd /tmp/extensions
    pecl install amqp-1.9.4.tgz
    docker-php-ext-enable amqp
fi

if [ -z "${EXTENSIONS##*,rar,*}" ]; then
    echo "---------- Install rar ----------"
    printf "\n" | pecl install rar
    docker-php-ext-enable rar
fi

if [ -z "${EXTENSIONS##*,ast,*}" ]; then
    echo "---------- Install ast ----------"
    printf "\n" | pecl install ast
    docker-php-ext-enable ast
fi

if [ -z "${EXTENSIONS##*,msgpack,*}" ]; then
    echo "---------- Install msgpack ----------"
    printf "\n" | pecl install msgpack
    docker-php-ext-enable msgpack
fi

if [ -z "${EXTENSIONS##*,igbinary,*}" ]; then
    echo "---------- Install igbinary ----------"
    printf "\n" | pecl install igbinary
    docker-php-ext-enable igbinary
fi

if [ -z "${EXTENSIONS##*,seaslog,*}" ]; then
    echo "---------- Install seaslog ----------"
    printf "\n" | pecl install seaslog
    docker-php-ext-enable seaslog
fi


if [ -z "${EXTENSIONS##*,redis,*}" ]; then
    echo "---------- Install redis ----------"
    mkdir redis \
    && tar -xf redis-4.1.1.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make ${MC} && make install ) \
    && docker-php-ext-enable redis
fi


if [ -z "${EXTENSIONS##*,memcached,*}" ]; then
    echo "---------- Install memcached ----------"
	apk add --no-cache libmemcached-dev zlib-dev
    printf "\n" | pecl install memcached-3.1.3
    docker-php-ext-enable memcached
fi


if [ -z "${EXTENSIONS##*,xdebug,*}" ]; then
    echo "---------- Install xdebug ----------"
    mkdir xdebug \
    && tar -xf xdebug-2.6.1.tgz -C xdebug --strip-components=1 \
    && ( cd xdebug && phpize && ./configure && make ${MC} && make install ) \
    && docker-php-ext-enable xdebug
fi


if [ -z "${EXTENSIONS##*,swoole,*}" ]; then
    echo "---------- Install swoole ----------"
    mkdir swoole \
    && tar -xf swoole-4.4.2.tgz -C swoole --strip-components=1 \
    && ( cd swoole && phpize && ./configure --enable-openssl && make ${MC} && make install ) \
    && docker-php-ext-enable swoole
fi

if [ -z "${EXTENSIONS##*,pdo_sqlsrv,*}" ]; then
    echo "---------- Install pdo_sqlsrv ----------"
	apk add --no-cache unixodbc-dev
    pecl install pdo_sqlsrv
    docker-php-ext-enable pdo_sqlsrv
fi

if [ -z "${EXTENSIONS##*,sqlsrv,*}" ]; then
    echo "---------- Install sqlsrv ----------"
	apk add --no-cache unixodbc-dev
    printf "\n" | pecl install sqlsrv
    docker-php-ext-enable sqlsrv
fi
