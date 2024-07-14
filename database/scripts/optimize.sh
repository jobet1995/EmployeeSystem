#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
LOG_FILE="./database/logs/optimize.log"

echo "Optimizing the database..." | tee -a $LOG_FILE

sqlite3 $DATABASE_FILE "VACUUM;" | tee -a $LOG_FILE
sqlite3 $DATABASE_FILE "ANALYZE;" | tee -a $LOG_FILE

echo "Database optimization complete." | tee -a $LOG_FILE