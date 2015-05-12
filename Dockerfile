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
RUN echo "#!/bin/sh\nservice nginx start && service php5-fpm start && service mysql start" > /start.sh
RUN echo "[supervisord]\nnodaemon=true\n\n[program:sshd]\ncommand=/usr/sbin/sshd -D\n\n[program:start]\ncommand=/start.sh" > /etc/supervisor/conf.d/supervisord.conf
RUN chmod a+x /start.sh
EXPOSE 80
CMD ["/usr/bin/supervisord"]
