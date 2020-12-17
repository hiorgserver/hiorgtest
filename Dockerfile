FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN \
 apt-get update &&\
 echo "mysql-server mysql-server/root_password password root" | debconf-set-selections &&\
 echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections &&\
 apt-get -y --no-install-recommends install \
   ca-certificates git openssh-client curl mariadb-server mariadb-client unzip apt-transport-https \
   php7.3-cli php7.3-curl php7.3-gd php7.3-intl php7.3-mbstring php7.3-mysqli php7.3-soap \
   php7.3-xdebug php7.3-xml php7.3-zip php7.3-bcmath \
   chromium wget zip &&\
 apt-get autoclean && apt-get clean && apt-get autoremove

RUN \
 curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin &&\
 curl -sSL https://phar.phpunit.de/phpunit-6.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit  &&\
 rm -rf /root/.composer /tmp/* /var/lib/apt/lists/*

RUN \
 CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` &&\
 curl -o ~/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip &&\
 unzip ~/chromedriver_linux64.zip -d ~/ &&\
 rm ~/chromedriver_linux64.zip &&\
 mv -f ~/chromedriver /usr/local/bin/chromedriver &&\
 chown root:root /usr/local/bin/chromedriver &&\
 chmod 0755 /usr/local/bin/chromedriver

ADD *.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh

RUN /usr/local/bin/init_db.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
