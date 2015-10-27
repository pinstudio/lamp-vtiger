FROM tutum/lamp:latest
MAINTAINER Barabanov Mikhail <Barabanov.Mikle@gmail.com> https://github.com/yfer
RUN apt-get update && apt-get -y install php5-gd php5-imap php5-curl
RUN php5enmod imap
RUN rm -fr /app
ADD vtigercrm /app
ADD customphp.ini /etc/php5/apache2/conf.d/customphp.ini
ADD vtigercron /etc/cron.d/
RUN chown -R www-data:www-data /app
RUN chmod -R 755 /app
RUN chmod +x /app/cron/vtigercron.sh
EXPOSE 80 3306
CMD ["/run.sh"]