#!/bin/bash

setup_config() {
    log "Configurazione Percona Server cluster-ready (standalone)..."
    
    # Backup configurazione originale se esiste
    if [[ -f "$STANDARD_CONFIG_FILE" ]]; then
        cp "$STANDARD_CONFIG_FILE" "${STANDARD_CONFIG_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Calcolo memoria disponibile
    TOTAL_MEM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    INNODB_BUFFER_SIZE=$((TOTAL_MEM * 70 / 100 / 1024))  # 70% della RAM in MB
    
    cat > "$STANDARD_CONFIG_FILE" << EOF
[mysqld]
# Basic Configuration
port = 3306
bind-address = 0.0.0.0
socket = /var/run/mysqld/mysqld.sock
datadir = /var/lib/mysql
tmpdir = /tmp

# Storage Engine
default_storage_engine = InnoDB

# Performance Tuning
max_connections = 200
innodb_buffer_pool_size = ${INNODB_BUFFER_SIZE}M
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
innodb_doublewrite = 1

# Query Cache
query_cache_type = 1
query_cache_size = 64M

# Temporary Tables
tmp_table_size = 128M
max_heap_table_size = 128M

# Thread and Table Cache
thread_cache_size = 16
table_open_cache = 2048

# Binary Logging - CLUSTER READY CONFIGURATION
log_bin = mysql-bin
binlog_format = ROW
server_id = 1
gtid_mode = ON
enforce_gtid_consistency = ON

# InnoDB Settings - CLUSTER READY
innodb_autoinc_lock_mode = 2
innodb_locks_unsafe_for_binlog = 1

# Logging
log_error = /var/log/mysql/error.log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2

# Security
local_infile = 0
skip_show_database

# Character Set
character_set_server = utf8mb4
collation_server = utf8mb4_unicode_ci

# Percona Features
thread_handling = pool-of-threads
extra_port = 33061
extra_max_connections = 10
EOF
    
    log "✅ Configurazione cluster-ready applicata (modalità standalone)"
    log "✅ Binary logging ROW format attivato"
    log "✅ GTID abilitato"
    log "✅ InnoDB configurato per cluster"
}
