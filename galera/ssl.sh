#!/bin/bash

setup_ssl() {
    log "Configurazione SSL per Percona/Cluster..."
    
    local ssl_dir="/etc/mysql/ssl"
    mkdir -p "$ssl_dir"
    
    # Generazione certificati self-signed
    openssl genrsa 2048 > "$ssl_dir/ca-key.pem"
    openssl req -new -x509 -nodes -days 3600 -key "$ssl_dir/ca-key.pem" -out "$ssl_dir/ca-cert.pem" -subj "/C=IT/ST=Lazio/L=Rome/O=Percona/CN=CA"
    
    openssl req -newkey rsa:2048 -days 3600 -nodes -keyout "$ssl_dir/server-key.pem" -out "$ssl_dir/server-req.pem" -subj "/C=IT/ST=Lazio/L=Rome/O=Percona/CN=Server"
    openssl rsa -in "$ssl_dir/server-key.pem" -out "$ssl_dir/server-key.pem"
    openssl x509 -req -in "$ssl_dir/server-req.pem" -days 3600 -CA "$ssl_dir/ca-cert.pem" -CAkey "$ssl_dir/ca-key.pem" -set_serial 01 -out "$ssl_dir/server-cert.pem"
    
    openssl req -newkey rsa:2048 -days 3600 -nodes -keyout "$ssl_dir/client-key.pem" -out "$ssl_dir/client-req.pem" -subj "/C=IT/ST=Lazio/L=Rome/O=Percona/CN=Client"
    openssl rsa -in "$ssl_dir/client-key.pem" -out "$ssl_dir/client-key.pem"
    openssl x509 -req -in "$ssl_dir/client-req.pem" -days 3600 -CA "$ssl_dir/ca-cert.pem" -CAkey "$ssl_dir/ca-key.pem" -set_serial 01 -out "$ssl_dir/client-cert.pem"
    
    # Correzione permessi
    chown -R mysql:mysql "$ssl_dir"
    chmod 600 "$ssl_dir"/*.pem
    
    # Aggiunta configurazione SSL
    cat >> "$CLUSTER_CONFIG_FILE" << EOF

# SSL Configuration
ssl-ca=$ssl_dir/ca-cert.pem
ssl-cert=$ssl_dir/server-cert.pem
ssl-key=$ssl_dir/server-key.pem

# SSL per cluster
wsrep_provider_options="socket.ssl_key=$ssl_dir/server-key.pem;socket.ssl_cert=$ssl_dir/server-cert.pem;socket.ssl_ca=$ssl_dir/ca-cert.pem"
EOF
    
    log "SSL configurato. Riavvia MySQL per applicare le modifiche"
}
