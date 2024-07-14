#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
LOG_FILE="./database/logs/test.log"

echo "Running database tests..." | tee -a $LOG_FILE

TEST_QUERIES=(
    "SELECT COUNT(*) FROM users;"
    "SELECT COUNT(*) FROM orders;"
    "PRAGMA integrity_check;"
)

for query in "${TEST_QUERIES[@]}"; do
    echo "Executing test query: $query" | tee -a $LOG_FILE
    result=$(sqlite3 $DATABASE_FILE "$query")
    echo "Result: $result" | tee -a $LOG_FILE
done

echo "Database tests complete." | tee -a $LOG_FILE