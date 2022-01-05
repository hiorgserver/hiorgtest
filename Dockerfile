FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

COPY yaml.ini /etc/php/7.4/mods-available/yaml.ini

RUN \
    php_version=7.4 \
    && apt-get update \
    && echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get -y install wget apt-transport-https lsb-release ca-certificates curl \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
	  && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        git unzip \
        build-essential \
        php${php_version}-apcu \
        php${php_version}-bcmath \
        php${php_version}-cli \
        php${php_version}-curl \
        php${php_version}-dom \
        php${php_version}-gd \
        php${php_version}-intl \
        php${php_version}-mbstring \
        php${php_version}-mysqli \
        php${php_version}-soap \
	php${php_version}-uopz \
        php${php_version}-xml \
        php${php_version}-zip \
        php${php_version}-dev \
        php${php_version}-xdebug \
        libyaml-dev \
        php-pear \
        wget \
        openssh-client \
        mariadb-server mariadb-client \
        chromium \
        zip \
    && pecl install yaml \
    && phpenmod -v ${php_version} yaml \
    && rm /etc/localtime && echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get autoremove && apt-get autoclean && apt-get clean \
    && curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin \
    && rm -rf /root/.composer /tmp/* /var/lib/apt/lists/*

RUN \
    curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin \
    && curl -sSL https://phar.phpunit.de/phpunit-6.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit  \
    && rm -rf /root/.composer /tmp/* /var/lib/apt/lists/*

RUN \
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
    && curl -o ~/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip ~/chromedriver_linux64.zip -d ~/ \
    && rm ~/chromedriver_linux64.zip \
    && mv -f ~/chromedriver /usr/local/bin/chromedriver \
    && chown root:root /usr/local/bin/chromedriver \
    && chmod 0755 /usr/local/bin/chromedriver

ADD *.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh

RUN /usr/local/bin/init_db.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
