#!/usr/bin/env bash

# example usage:
# bash$ cd /home/PATRICKB/mysql_dumps
# bash$ MYSQL_PASS="mysql database password" MARIA_PASS="mariadb password" ./backup_restore.sh


MYSQL_PATH=/usr/local/mysql/bin
MARIA_PATH=/QOpenSys/pkgs/bin
TEMP_PATH=/home/PATRICKB
printf -v date '%(%Y-%m-%d_%H:%M:%S)T' -1 

function backup_restore() {
    $MYSQL_PATH/mysqldump -u root -p"$MYSQL_PASS" $1 > $TEMP_PATH/$1.sql
    $MARIA_PATH/mysqladmin -u root -p"$MARIA_PASS" -f drop $1
    $MARIA_PATH/mysqladmin -u root -p"$MARIA_PASS" create $1
    $MARIA_PATH/mysql -u root -p"$MARIA_PASS" $1 < /home/PATRICKB/$1.sql
    mv ./../$1.sql $1_$date.sql
}

DB=database1
backup_restore $DB

DB=database2
backup_restore $DB
