#!/usr/bin/env sh 
BACKUP_PATH='/mnt/old-hdd/backup/rasp-backup.img'
SERVICES="cron tomcat7 deluge-daemon samba rsync postgresql"

for service in $SERVICES
do
  echo "Stopping $service..."
  /etc/init.d/$service stop
done


echo "Backing up image"
dd if=/dev/mmcblk0 of=$BACKUP_PATH

for service in $SERVICES
do
  echo "Starting $service..."
  /etc/init.d/$service start
done
