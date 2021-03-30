#!/bin/bash

if  ! cmp /etc/nginx/sites-available/default autoindex_on
then
	rm -rf /var/www/html/index.nginx-debian.html
	cp autoindex_on /etc/nginx/sites-available/default
	echo "AutoIndex -> ON"
else
	cp index.nginx-debian.html /var/www/html/index.nginx-debian.html
	cp autoindex_off /etc/nginx/sites-available/default
	echo "AutoIndex -> OFF"
fi

service nginx reload 
service nginx restart

bash