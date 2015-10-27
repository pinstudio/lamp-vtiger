FROM tutum/lamp:latest
RUN rm -fr /app
ADD vtigercrm /app
EXPOSE 80 3306
CMD ["/run.sh"]