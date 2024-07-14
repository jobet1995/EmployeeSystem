#!/bin/bash

set -e

DATABASE_FILE="./database/crm.sqlite"
SEED_FILE="./database/migrations/003_seed_data.sql"
LOG_FILE="./database/logs/seed.log"

echo "Seeding the database..." | tee -a $LOG_FILE

sqlite3 $DATABASE_FILE < $SEED_FILE

echo "Database seeding complete." | tee -a $LOG_FILE