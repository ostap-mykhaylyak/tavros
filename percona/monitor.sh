#!/bin/bash
log "Monitoraggio Percona..."
mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "SHOW STATUS LIKE 'Threads_connected';"
