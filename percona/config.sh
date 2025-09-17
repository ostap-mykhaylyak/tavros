#!/bin/bash
log "Configurazione Percona..."
cat > "$STANDARD_CONFIG_FILE" <<EOF
[mysqld]
bind-address=0.0.0.0
binlog_format=ROW
gtid_mode=ON
enforce_gtid_consistency=ON
innodb_autoinc_lock_mode=2
EOF
systemctl restart mysql
log "✅ Configurazione applicata"
