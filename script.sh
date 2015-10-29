#!/bin/sh

# install and enable vtiger module references
apt-get update
apt-get -y install binutils cpp flex gcc  libarchive-zip-perl libc6-dev libpcre3 libpopt-dev lynx m4 make ncftp nmap openssl perl perl-modules unzip zip zlib1g-dev autoconf automake1.9 libtool bison autotools-dev gcc libpng12-dev libjpeg62-dev libfreetype6-dev libssl-dev libxml2-dev libxml2 g++ gawk php5-gd php5-imap php5-curl php-pear php5-dev
# TODO: check php5-zlib libcompress-zlib-perl
php5enmod imap
pecl install timezonedb
localedef -i ru_RU -f CP1251 CP1251
localedef -i ru_RU -f UTF-8 UTF-8
localedef -i en_US -f ISO-8859-1 ISO-8859-1

# download, untar and directory rights
rm -fr /app
wget -O vtiger.tar.gz $1
tar zxf vtiger.tar.gz
mv /vtigercrm /app
rm /vtiger.tar.gz
chown -R www-data:www-data /app
find /app -type f -exec chmod 644 {} \;
find /app -type d -exec chmod 755 {} \;

# vtiger specific php.ini settings
mv customphp.ini /etc/php5/apache2/conf.d/customphp.ini

# vtiger specific mysql settings
mv utf8.cnf /etc/mysql/conf.d/utf8.cnf

# vtiger scheduler
chmod +x /app/cron/vtigercron.sh
mv vtigercron /etc/cron.d/
mv supervisord-cron.conf /etc/supervisor/conf.d/supervisord-cron.conf
