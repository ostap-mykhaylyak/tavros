#!/bin/bash
log "Configuro SSL per cluster..."
ssl_dir="/etc/mysql/ssl"; mkdir -p "$ssl_dir"
openssl req -new -x509 -nodes -days 365 -subj "/CN=mysql" -keyout "$ssl_dir/server-key.pem" -out "$ssl_dir/server-cert.pem"
cat >> "$CLUSTER_CONFIG_FILE" <<EOF
ssl-ca=$ssl_dir/server-cert.pem
ssl-cert=$ssl_dir/server-cert.pem
ssl-key=$ssl_dir/server-key.pem
EOF
log "✅ SSL configurato"
