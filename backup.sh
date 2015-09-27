#!/usr/bin/env sh 
BACKUP_PATH='/mnt/old-hdd/backup/rasp-backup.img'
SERVICES="cron tomcat7 deluge-daemon samba rsync postgresql"

CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "$CURRENT_TIME Started backup process"

for service in $SERVICES
do
  echo "Stopping $service..."
  /etc/init.d/$service stop
done

IMAGING_START_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "$IMAGING_START_TIME Image creation started"

dd if=/dev/mmcblk0 of=$BACKUP_PATH

IMAGE_COMPLETED_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "$IMAGE_COMPLETED_TIME Image successfully created"

for service in $SERVICES
do
  echo "Starting $service..."
  /etc/init.d/$service start
done

SCRIPT_COMPLETE_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "$SCRIPT_COMPLETE_TIME Backup process was successfull"
