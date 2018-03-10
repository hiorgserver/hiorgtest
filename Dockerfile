FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

RUN \
 apt-get update &&\
 echo "mysql-server mysql-server/root_password password root" | debconf-set-selections &&\
 echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections &&\
 apt-get -y --no-install-recommends install \
   ca-certificates git openssh-client curl mysql-server mysql-client apt-transport-https \
   php7.0-cli php7.0-mcrypt php7.0-curl php7.0-soap &&\
 apt-get autoclean && apt-get clean && apt-get autoremove

RUN \
 curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin &&\
 curl -sSL https://phar.phpunit.de/phpunit-6.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit  &&\
 rm -rf /root/.composer /tmp/* /var/lib/apt/lists/*

COPY ./init_db.sh /usr/local/bin/init_db.sh

RUN chmod +x /usr/local/bin/init_db.sh && /usr/local/bin/init_db.sh