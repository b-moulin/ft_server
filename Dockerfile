FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

RUN apt-get -y install nginx

WORKDIR /etc/nginx/sites-available

COPY default .

WORKDIR ../../../

ADD ./srcs/autoindex_on .
ADD ./srcs/autoindex_off .
ADD ./srcs/switch_autoindex.sh .

RUN apt-get -y install mariadb-server

RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring 

WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin


ADD ./srcs/config.inc.php phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

ADD ./srcs/wp-config.php /var/www/html

RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Korea/L=Seoul/O=innoaca/OU=42seoul/CN=forhjy" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
ADD ./srcs/init.sh ./
CMD bash init.sh

# WORKDIR ../../../
# CMD cp /var/www/html/index.nginx-debian.html .

# CMD reload nginx
# CMD restart nginx


#RUN bash init.sh


