#!/bin/bash

# Gestione utenti
manage_user() {
    local action="$1"
    local username="$2"
    local password="${3:-$(generate_password)}"
    local database="${4:-*}"
    local host="${5:-localhost}"
    
    case "$action" in
        "create")
            log "Creazione utente: $username@$host"
            mysql --defaults-file="$MYSQL_CONFIG_FILE" << EOF
CREATE USER IF NOT EXISTS '$username'@'$host' IDENTIFIED BY '$password';
GRANT ALL PRIVILEGES ON \`$database\`.* TO '$username'@'$host';
FLUSH PRIVILEGES;
EOF
            log "Utente '$username@$host' creato con password: $password"
            ;;
        "delete")
            log "Eliminazione utente: $username@$host"
            mysql --defaults-file="$MYSQL_CONFIG_FILE" << EOF
DROP USER IF EXISTS '$username'@'$host';
FLUSH PRIVILEGES;
EOF
            log "Utente '$username@$host' eliminato"
            ;;
        "reset_password")
            log "Reset password per utente: $username@$host"
            mysql --defaults-file="$MYSQL_CONFIG_FILE" << EOF
ALTER USER '$username'@'$host' IDENTIFIED BY '$password';
FLUSH PRIVILEGES;
EOF
            log "Password resettata per utente '$username@$host': $password"
            ;;
    esac
}
