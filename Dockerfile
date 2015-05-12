FROM debian
RUN apt-get update
RUN apt-get install -qy vim \
    ssh \
    curl \
    wget \
    git \
    openssh-server \
    supervisor \
    mysql-server \
    mysql-client \
    php5-mysql \
    php5-fpm \
    nginx
RUN mkdir -p /var/run/sshd /var/log/supervisor /var/www/html
RUN echo "<?php\nphpinfo();" > /var/www/html/index.php
COPY confs/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY confs/nginx/default.conf /etc/nginx/sites-enabled/default
COPY confs/fpm/www.conf /etc/php5/fpm/pool.d/www.conf
COPY confs/php/php.ini /etc/php5/fpm/php.ini
EXPOSE 80
CMD ["/usr/bin/supervisord"]
