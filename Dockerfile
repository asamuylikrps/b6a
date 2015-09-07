##
## Docker container for blockanalytics test stage
##
#FROM remedypointsolution/b6a.webserver.qa
FROM tutum/apache-php

MAINTAINER asamuylik@remedypointsolutions.com

RUN apt-get update -y
RUN apt-get install -y 	\
		vim 			\
		memcached		\
		php5-xdebug		\
		php5-memcached

ADD phpinfo/    /var/www/phpinfo/
ADD conf/php/  /etc/php5/apache2/conf.d/
ADD vhosts/    /etc/apache2/sites-available/

RUN ln -s /etc/apache2/sites-available/minnesotaunited.conf /etc/apache2/sites-enabled/minnesotaunited.conf
RUN ln -s /etc/apache2/sites-available/phpinfo.conf /etc/apache2/sites-enabled/phpinfo.local.conf

#ENTRYPOINT ["/run.sh"]

