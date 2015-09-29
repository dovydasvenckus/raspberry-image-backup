# Raspberry pi backup script
## Description
Simple script that stops services and makes system image using dd

## Usage
### Normal
1. Change BACKUP_PATH parameter to point where you wan't backup saved. Change SERVICES variable to include your services.
2. Chmod script to be executable
2. Execute script as sudo 

### Cron example
This script will run every monday at 2:30 AM. And will log output /home/pi/backup.log

    30 2 * * 1 /usr/bin/backup.sh > /home/pi/backup.log


## Variables
### COMPRESSION
* NONE - does not compress image
* GZIP - uses gzip compression to compress image
* PIGZ = uses all cores to compress image using GZIP algorithm **(requires pigz package)**
