#!/bin/bash
ACTION=${1:-""}; USER=${2:-""}; PASS=${3:-$(generate_password)}
case "$ACTION" in
  create)
    log "Creo utente $USER"
    mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';"
    mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "GRANT ALL ON *.* TO '$USER'@'%';"
    log "Utente creato con password: $PASS"
    ;;
  drop)
    log "Elimino utente $USER"
    mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "DROP USER IF EXISTS '$USER'@'%';"
    ;;
  *)
    error "Uso: $0 users {create|drop} <username> [password]"
    ;;
esac
