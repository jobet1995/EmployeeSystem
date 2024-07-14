#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
MIGRATIONS_DIR="./database/migrations"
LOG_FILE="./database/logs/setup.log"
SCHEMA_FILE="./database/schema.sql"

echo "Setting up the SQLite database..." | tee -a $LOG_FILE

if [ -f "$DATABASE_FILE" ]; then
    echo "Database file already exists. Removing it for a fresh setup." | tee -a $LOG_FILE
    rm $DATABASE_FILE
fi

touch $DATABASE_FILE

echo "Running migrations..." | tee -a $LOG_FILE
for migration in $MIGRATIONS_DIR/*.sql; do
    echo "Applying migration: $migration" | tee -a $LOG_FILE
    sqlite3 $DATABASE_FILE < $migration
done

echo "Extracting current database schema..." | tee -a $LOG_FILE
sqlite3 $DATABASE_FILE .schema > $SCHEMA_FILE

echo "Validating database schema..." | tee -a $LOG_FILE
./database/scripts/validate_schema.sh

echo "Database setup complete." | tee -a $LOG_FILE