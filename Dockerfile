FROM tutum/lamp:latest
MAINTAINER Barabanov Mikhail <Barabanov.Mikle@gmail.com> https://github.com/yfer
# install and enable vtiger module references
RUN apt-get update && apt-get -y install php5-gd php5-imap php5-curl curl
RUN php5enmod imap
# add vtiger files and file rights/modes
RUN rm -fr /app
#ADD vtigercrm /app download and untar
ADD $VTIGER_SOURCE /vtiger.tar.gz
RUN tar zxf vtiger.tar.gz
RUN mv /vtigercrm /app
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
