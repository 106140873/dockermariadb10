#!/bin/bash
#
    if [ ! -d "/var/lib/mysql/mysql" ]; then
        mysql_install_db --user=mysql --datadir=/var/lib/mysql
        mysqld_safe &
        sleep 5s
    else
        mysqld_safe &
    fi
tail -f /opt/readme.txt
