FROM ubuntu
RUN apt-get update
RUN apt-get -y install apache2
COPY webfile/ /var/www/html/
ENTRYPOINT apachectl -D FOREGROUND