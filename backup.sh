#!/usr/bin/env bash

POSTGRESQL_DESTINATION="$BACKUP_PATH:-/backup"

BACKUP_POSTGRESQL_USER=${DB_USER:-postgres}

BACKUP_POSTGRESQL_PASSWORD=${DB_PASS:-}

if [[ ${BACKUP_POSTGRESQL_HOST+defined} = defined ]]; then
    if [ ! -d "$POSTGRESQL_DESTINATION" ]; then
        mkdir -p "$POSTGRESQL_DESTINATION"
    fi

    eval "PGPASSWORD='$BACKUP_POSTGRESQL_PASSWORD' pg_dumpall --host '$BACKUP_POSTGRESQL_HOST' --user '$BACKUP_POSTGRESQL_USER' > $POSTGRESQL_DESTINATION/$(date +%Y%m%dT%H%MZ%z)-all.sql"

else
    rm -rf "$POSTGRESQL_DESTINATION"
fi
