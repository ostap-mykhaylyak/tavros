#!/bin/bash

percona_users() {
  local action=${1:-""}
  shift || true

  case "$action" in
    create)
      require_params 2 "$@"   # deve avere almeno 2 parametri (username e password opzionale)
      local user=$1
      local pass=${2:-$(generate_password)}

      log "Creating user $user"
      mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "CREATE USER '$user'@'%' IDENTIFIED BY '$pass';"
      mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "GRANT ALL ON *.* TO '$user'@'%';"
      ;;
    drop)
      require_params 1 "$@"   # almeno 1 parametro: username
      local user=$1

      log "Dropping user $user"
      mysql --defaults-file="$MYSQL_CONFIG_FILE" -e "DROP USER IF EXISTS '$user'@'%';"
      ;;
    *)
      error "Usage: $0 users {create|drop} <username> [password]"
      ;;
  esac
}
