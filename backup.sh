#!/usr/bin/env sh 
BACKUP_PATH='/mnt/old-hdd/backup/'
SERVICES="cron tomcat7 deluge-daemon samba rsync postgresql"
IMAGE_NAME='raspberry-backup'
BACKUP_DATE=$(date "+%Y-%m-%d")
IMAGE_FILE_NAME="$BACKUP_PATH$IMAGE_NAME-$BACKUP_DATE.img"

log(){
  CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$CURRENT_TIME $1"
}

log "Started backup process"

for service in $SERVICES
do
  log "Stopping $service..."
  /etc/init.d/$service stop
done

log "Image creation started"

dd if=/dev/mmcblk0 of=$IMAGE_FILE_NAME

log "Image successfully created"

for service in $SERVICES
do
  log "Starting $service..."
  /etc/init.d/$service start
done

