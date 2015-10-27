FROM tutum/lamp:latest
MAINTAINER Barabanov Mikhail <Barabanov.Mikle@gmail.com> https://github.com/yfer
RUN apt-get update && apt-get -y install php5-gd php5-imap
RUN rm -fr /app
ADD vtigercrm /app
EXPOSE 80 3306
CMD ["/run.sh"]