FROM tutum/lamp:latest
MAINTAINER Barabanov Mikhail <Barabanov.Mikle@gmail.com> https://github.com/yfer

# install and enable vtiger module references
RUN apt-get update && apt-get -y install binutils cpp flex gcc  libarchive-zip-perl libc6-dev libcompress-zlib-perl libpcre3 libpopt-dev lynx m4 make ncftp nmap openssl perl perl-modules unzip zip zlib1g-dev autoconf automake1.9 libtool bison autotools-dev gcc libpng12-dev libjpeg62-dev libfreetype6-dev libssl-dev libxml2-dev libxml2 g++ gawk 
# check php5-zlib
RUN php5enmod imap

# download, untar and directory rights
RUN rm -fr /app
ENV VTIGER_SOURCE http://sources.pinstudio.ru/salesplatform-vtigercrm-6.3.0-201507.tar.gz
ADD $VTIGER_SOURCE /vtiger.tar.gz
RUN tar zxf vtiger.tar.gz
RUN mv /vtigercrm /app
RUN rm /vtiger.tar.gz
RUN chown -R www-data:www-data /app
RUN find /app -type f -exec chmod 644 {} \;
RUN find /app -type d -exec chmod 755 {} \;

# vtiger specific php.ini settings
ADD customphp.ini /etc/php5/apache2/conf.d/customphp.ini

# vtiger scheduler
RUN chmod +x /app/cron/vtigercron.sh
ADD vtigercron /etc/cron.d/
ADD supervisord-cron.conf /etc/supervisor/conf.d/supervisord-cron.conf

EXPOSE 80 3306
CMD ["/run.sh"]
