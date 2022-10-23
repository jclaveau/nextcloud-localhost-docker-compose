cd /var/www/html
su host_user -c "/usr/local/bin/php occ files:scan --all > /var/log/nextcloud/cron_scan.log 2>&1"

