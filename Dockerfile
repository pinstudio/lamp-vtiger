FROM tutum/lamp:latest
MAINTAINER Barabanov Mikhail <Barabanov.Mikle@gmail.com> https://github.com/yfer

ADD . /
ENV VTIGER_SOURCE http://sources.pinstudio.ru/salesplatform-vtigercrm-6.3.0-201507.tar.gz
RUN sh script.sh ${VTIGER_SOURCE}

EXPOSE 80 3306
CMD ["/run.sh"]
