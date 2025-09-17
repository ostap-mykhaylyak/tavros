#!/bin/bash

# Sicurezza Percona
secure_percona() {
    log "Applicazione configurazioni di sicurezza..."
    
    mysql --defaults-file="$MYSQL_CONFIG_FILE" << EOF
-- Rimozione utenti anonimi
DELETE FROM mysql.user WHERE User='';

-- Rimozione accesso root remoto (eccetto cluster)
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Rimozione database test
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- Flush privilegi
FLUSH PRIVILEGES;
EOF
    
    log "Configurazioni di sicurezza applicate"
}
