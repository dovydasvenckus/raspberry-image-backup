#!/usr/bin/env sh 
FILE_SYSTEM_PATH="/dev/mmcblk0"
BACKUP_PATH='/mnt/old-hdd/backup/'
SERVICES="cron tomcat7 deluge-daemon samba rsync postgresql"
IMAGE_NAME='raspberry-backup'
BACKUP_DATE=$(date "+%Y-%m-%d")
IMAGE_FILE_NAME="$BACKUP_PATH$IMAGE_NAME-$BACKUP_DATE.img"
COMPRESSION="GZIP"

log(){
  CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$CURRENT_TIME $1"
}

execute_for_each_service(){
  for service in $SERVICES
    do
     log "$1ing $service..."
     /etc/init.d/$service $1
  done
}

create_image(){
  if [ "$1" = "NONE" ]
    then
      dd if=$FILE_SYSTEM_PATH of=$IMAGE_FILE_NAME
  elif [ "$1" = "GZIP" ]
    then
      dd if=$FILE_SYSTEM_PATH | gzip > "$IMAGE_FILE_NAME.gz"
  fi
}

log "Started backup process"

execute_for_each_service "stop"

log "Image creation started"

create_image $COMPRESSION

log "Image successfully created"

execute_for_each_service "start"
