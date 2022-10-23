FROM nextcloud:apache
# FROM nextcloud:stable-apache

ARG HOST_UID
ENV HOST_UID=$HOST_UID
ENV APACHE_RUN_USER host_user
RUN adduser --uid $HOST_UID --gecos 'current_host_user' --disabled-password host_user \
  && chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" /var/lock/apache2 /var/run/apache2
  # && usermod -aG sudo host_user

RUN apt-get update

# https://www.howtogeek.com/devops/how-to-use-cron-with-your-docker-containers/
COPY run_scan.sh /opt/run_scan.sh
# COPY run_scan.sh /var/www/html/run_scan.sh
RUN apt-get install -y cron nano\
  && echo "* * * * * host_user /opt/run_scan.sh" > /etc/cron.d/nextcloud_files_scan\
  && crontab /etc/cron.d/nextcloud_files_scan\
  && mkdir /var/log/nextcloud\
  && chmod 777 /var/log/nextcloud
# RUN apt-get install -y inotify-tools git
# python3


COPY custom_entrypoint.sh /custom_entrypoint.sh
ENTRYPOINT ["/custom_entrypoint.sh"]
CMD ["apache2-foreground"]

    # apt-get clean all

# RUN pecl install inotify\
#   && echo "extension=inotify.so" > /usr/local/etc/php/conf.d/pecl-php-ext-inotify.ini
# RUN php occ app:install files_inotify
# occ files_external:notify -v 5

# RUN cd /opt\
#   && git clone https://github.com/Blaok/nextcloud-inotifyscan\
#   && cd nextcloud-inotifyscan\
#   && make install
# # RUN apt-get update && apt-get install inotify-tools\
# #   && cd /opt\
# #   && git clone https://github.com/Blaok/nextcloud-inotifyscan\
# #   && cd nextcloud-inotifyscan\
# #   && make install
# COPY ./nextcloud-inotify.config.ini /etc/nextcloud-inotifyscan/host_user.ini
# RUN systemctl enable --now nextcloud-inotifyscan@host_user