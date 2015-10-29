#!/bin/sh

# install and enable vtiger module references
apt-get update
apt-get -y install php5-gd php5-imap php5-curl
php5enmod imap

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

# vtiger scheduler
chmod +x /app/cron/vtigercron.sh
mv vtigercron /etc/cron.d/
mv supervisord-cron.conf /etc/supervisor/conf.d/supervisord-cron.conf
