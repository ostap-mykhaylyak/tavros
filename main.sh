#!/bin/bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/config.sh"
source "$BASE_DIR/utils/logging.sh"
source "$BASE_DIR/utils/common.sh"

COMMAND=$1; shift || true

case "$COMMAND" in
  install)      source "$BASE_DIR/percona/install.sh" ;;
  configure)    source "$BASE_DIR/percona/config.sh" ;;
  secure)       source "$BASE_DIR/percona/secure.sh" ;;
  monitor)      source "$BASE_DIR/percona/monitor.sh" ;;
  users)        source "$BASE_DIR/percona/users.sh" ;;
  cluster)      source "$BASE_DIR/cluster/manage.sh" ;;
  convert)      source "$BASE_DIR/cluster/convert.sh" ;;
  ssl)          source "$BASE_DIR/cluster/ssl.sh" ;;
  backup)       source "$BASE_DIR/backup/logical.sh" ;;
  xtrabackup)   source "$BASE_DIR/backup/xtrabackup.sh" ;;
  maintenance)  source "$BASE_DIR/utils/maintenance.sh" ;;
  *)
    echo "Uso: $0 {install|configure|secure|monitor|users|cluster|convert|ssl|backup|xtrabackup|maintenance}"
    exit 1 ;;
esac
