#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
EXPECTED_SCHEMA="./database/expected_schema.sql"
LOG_FILE="./database/logs/validate_schema.log"

echo "Validating the database schema..." | tee -a $LOG_FILE

CURRENT_SCHEMA=$(sqlite3 $DATABASE_FILE .schema)

EXPECTED_SCHEMA_CONTENT=$(< $EXPECTED_SCHEMA)

if [ "$CURRENT_SCHEMA" != "$EXPECTED_SCHEMA_CONTENT" ]; then
    echo "Schema validation failed. Current schema does not match the expected schema." | tee -a $LOG_FILE
    echo "Expected schema:" | tee -a $LOG_FILE
    echo "$EXPECTED_SCHEMA_CONTENT" | tee -a $LOG_FILE
    echo "Current schema:" | tee -a $LOG_FILE
    echo "$CURRENT_SCHEMA" | tee -a $LOG_FILE
    exit 1
else
    echo "Schema validation succeeded. Current schema matches the expected schema." | tee -a $LOG_FILE
fi