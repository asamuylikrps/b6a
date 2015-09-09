##
## Docker container for blockanalytics test stage
##
#FROM remedypointsolution/b6a.webserver.qa
FROM tutum/apache-php

MAINTAINER asamuylik@remedypointsolutions.com

RUN sudo apt-get update -y
RUN sudo apt-get install -y 	\
		vim	 					\
		memcached				\
		mysql-server			\
		php5-mcrypt				\
		php5-xdebug				\
		php5-memcache			\
		php5-memcached

ADD ./run  /run 
ADD ./data /data
ADD phpinfo/    /var/www/phpinfo/
ADD conf/php/   /etc/php5/apache2/conf.d/
ADD conf/mysql/ /etc/mysql/conf.d/
ADD conf/apache/vhosts/     /etc/apache2/sites-available/

RUN chmod +x /run/run.sh

RUN ln -s /etc/apache2/sites-available/minnesotaunited.conf /etc/apache2/sites-enabled/minnesotaunited.conf
RUN ln -s /etc/apache2/sites-available/phpinfo.conf /etc/apache2/sites-enabled/phpinfo.local.conf

RUN sed -i 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/apache2/php.ini

ENTRYPOINT ["/run/run.sh"]

