#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
BACKUP_DIR="./database/backups"
LOG_FILE="./database/logs/backup.log"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/crm_backup_$TIMESTAMP.sqlite"

echo "Creating backup of the database..." | tee -a $LOG_FILE

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p $BACKUP_DIR
fi

cp $DATABASE_FILE $BACKUP_FILE

echo "Backup created at $BACKUP_FILE." | tee -a $LOG_FILE