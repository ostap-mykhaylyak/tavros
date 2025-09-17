#!/bin/bash

install_percona() {
    log "Avvio installazione Percona Server ${PERCONA_VERSION} ..."
    
    # Aggiornamento sistema
    apt update && apt upgrade -y
    
    # Installazione dipendenze (incluse quelle per futuro cluster)
    apt install -y wget gnupg2 lsb-release curl software-properties-common socat pv qpress
    
    # Download e installazione chiave GPG Percona
    wget -qO - https://repo.percona.com/apt/percona-release_latest.generic_all.deb.asc | apt-key add -
    
    # Download repository Percona
    if [[ ! -f /tmp/percona-release.deb ]]; then
        wget -O /tmp/percona-release.deb https://repo.percona.com/apt/percona-release_latest.generic_all.deb
    fi
    
    dpkg -i /tmp/percona-release.deb
    apt update
    
    # Abilitazione repository Percona Server E tools
    percona-release setup ps80
    percona-release enable tools release
    
    # Generazione password se non fornita
    if [[ -z "$MYSQL_ROOT_PASSWORD" ]]; then
        MYSQL_ROOT_PASSWORD=$(generate_password)
        log "Password root Percona generata automaticamente"
    fi
    
    # Pre-configurazione installazione
    export DEBIAN_FRONTEND=noninteractive
    echo "percona-server-server percona-server-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
    echo "percona-server-server percona-server-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
    
    # Installazione SOLO Percona Server + XtraBackup + Toolkit (NO cluster packages)
    log "Installazione Percona Server (standalone) con strumenti cluster-ready..."
    apt install -y \
        percona-server-server \
        percona-server-client \
        percona-toolkit \
        percona-xtrabackup-80
    
    # NON installare percona-xtradb-cluster packages
    log "Percona Server installato SENZA pacchetti cluster (conversione disponibile)"
    
    # Configurazione ottimizzata per singolo nodo ma cluster-ready
    setup_cluster_ready_config
    
    # Avvio e abilitazione servizio
    systemctl start mysql
    systemctl enable mysql
    
    log "Percona Server ${PERCONA_VERSION} installato con successo"
}

# Configurazione file .my.cnf
setup_mysql_config() {
    log "Configurazione file .my.cnf..."
    
    cat > "$MYSQL_CONFIG_FILE" << EOF
[client]
user=root
password=$MYSQL_ROOT_PASSWORD
host=localhost
port=3306

[mysql]
auto-rehash
safe-updates

[mysqldump]
quick
lock-tables=false
single-transaction=true

[mysqladmin]
force

[xtrabackup]
user=$XTRABACKUP_USER
password=$XTRABACKUP_PASSWORD
EOF
    
    chmod 600 "$MYSQL_CONFIG_FILE"
    chown root:root "$MYSQL_CONFIG_FILE"
    
    log "File .my.cnf configurato"
}
