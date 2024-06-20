FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y apache2 zip unzip wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

RUN unzip /tmp/photogenic.zip -d /var/www/html/ && \
    cp -rvf /var/www/html/photogenic/* /var/www/html/ && \
    rm -rf /var/www/html/photogenic /tmp/photogenic.zip

CMD ["apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80