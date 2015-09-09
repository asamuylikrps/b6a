#!/bin/bash
chown www-data:www-data /app -R

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

source /etc/apache2/envvars

mysqld_safe >/dev/null 2>&1 &

sleep 4

mysqladmin -u root password 'root'

for sql in $(ls /run/db/); do
	mysql -uroot -proot < "/run/db/$sql"
done

for dump in $(ls /data/db/); do
	db_name=$(echo $dump | cut -d. -f1)
	gunzip -c "/data/db/$dump" | mysql -uroot -proot "$db_name"
done

exec apache2 -D FOREGROUND
