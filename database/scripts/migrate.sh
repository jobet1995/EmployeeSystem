#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
MIGRATIONS_DIR="./database/migrations"
LOG_FILE="./database/logs/migrate.log"

echo "Applying new migrations..." | tee -a $LOG_FILE

for migration in $MIGRATIONS_DIR/*.sql; do
    echo "Applying migration: $migration" | tee -a $LOG_FILE
    sqlite3 $DATABASE_FILE < $migration
done

echo "Migrations applied successfully." | tee -a $LOG_FILE