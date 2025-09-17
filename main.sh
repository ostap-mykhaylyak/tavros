#!/bin/bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/config.sh"
source "$BASE_DIR/utils/common.sh"

COMMAND=${1:-""}
shift || true

case "$COMMAND" in
  install)
    source "$BASE_DIR/percona/install.sh"
    percona_install "$@"  # <-- chiama la funzione
    ;;
  configure)
    source "$BASE_DIR/percona/config.sh"
    percona_configure "$@"
    ;;
  secure)
    source "$BASE_DIR/percona/secure.sh"
    percona_secure
    ;;
  monitor)
    source "$BASE_DIR/percona/monitor.sh"
    percona_monitor "$@"
    ;;
  users)
    source "$BASE_DIR/percona/users.sh"
    percona_users "$@"
    ;;
  cluster)
    source "$BASE_DIR/cluster/manage.sh"
    cluster_manage "$@"
    ;;
  convert)
    source "$BASE_DIR/cluster/convert.sh"
    cluster_convert "$@"
    ;;
  ssl)
    source "$BASE_DIR/cluster/ssl.sh"
    cluster_ssl "$@"
    ;;
  backup)
    source "$BASE_DIR/backup/logical.sh"
    backup_logical "$@"
    ;;
  xtrabackup)
    source "$BASE_DIR/backup/xtrabackup.sh"
    backup_xtrabackup "$@"
    ;;
  maintenance)
    source "$BASE_DIR/utils/maintenance.sh"
    maintenance_run
    ;;
  *)
    echo "Uso: $0 {install|configure|secure|monitor|users|cluster|convert|ssl|backup|xtrabackup|maintenance}"
    exit 1 ;;
esac
