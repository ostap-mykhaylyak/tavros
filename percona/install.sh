#!/bin/bash
log "Installazione Percona Server standalone cluster-ready..."
apt update && apt install -y percona-server-server percona-server-client percona-toolkit percona-xtrabackup-80
systemctl enable --now mysql
log "✅ Installazione Percona completata"
