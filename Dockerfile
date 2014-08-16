FROM ragb/nginx-static-serf

RUN add-apt-repository ppa:ondrej/php5
RUN apt-get update -qy
RUN apt-get install nginx-extras php5-fpm php-apc

# Make sure php-fpm is not ruining via upstart or something:
RUN service php5-fpm stop

ADD nginx-conf/ /etc/nginx

# Delete git crap, this is ugly.
RUN rm -rf /etc/nginx/.git

ADD php-conf/www.conf /etc/php5/fpm/pool.d/
ADD php-conf/php.in /etc/php5/fpm/
ADD supervisord-php5-fpm.conf /etc/supervisor/conf.d/supervisord-php5-fpm.conf

