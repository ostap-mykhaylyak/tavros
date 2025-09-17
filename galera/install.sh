#!/bin/bash

install_galera() {
    log "Avvio installazione Galera ..."
    apt update && apt upgrade -y
    apt install -y apt install galera-4
}
