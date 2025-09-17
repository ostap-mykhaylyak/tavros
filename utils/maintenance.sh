#!/bin/bash
log "Eseguo manutenzione automatica..."
# Ottimizza, fa backup e pulisce vecchi log/backup
mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "FLUSH LOGS;"
find /var/log/mysql/ -name "*.log" -mtime +7 -delete
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +30 -delete
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete
log "Manutenzione completata."
