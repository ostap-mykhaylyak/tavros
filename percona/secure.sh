#!/bin/bash
log "Eseguo hardening di sicurezza..."
mysql --defaults-file="$MYSQL_CONFIG_FILE" <<EOF
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF
log "✅ Sicurezza rafforzata"
