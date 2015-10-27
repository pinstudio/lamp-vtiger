FROM tutum/lamp:latest
MAINTAINER https://github.com/yfer
RUN rm -fr /app
ADD vtigercrm /app
EXPOSE 80 3306
CMD ["/run.sh"]