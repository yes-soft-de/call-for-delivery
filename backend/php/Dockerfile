FROM php:8.0-fpm

RUN apt-get update && apt-get install -y zlib1g-dev git libicu-dev zip libzip-dev zip librabbitmq-dev libssh-dev\
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && pecl install amqp \
    && docker-php-ext-enable amqp\
#    && pecl install grpc \
#    && docker-php-ext-enable grpc \
    && apt-get update \
    && apt-get install -y libxslt1-dev\
    && docker-php-ext-install xsl\
    && apt-get remove -y libxslt1-dev icu-devtools libicu-dev libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/c4d-backend

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN curl -sS https://get.symfony.com/cli/installer | bash
#RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony
RUN chown -R www-data:www-data /var && chmod -R g+rw /var
RUN apt-get update && apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev
RUN docker-php-ext-configure gd && docker-php-ext-install gd