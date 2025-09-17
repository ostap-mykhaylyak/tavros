#!/bin/bash
check_root() {
  [[ $EUID -ne 0 ]] && error "Questo script deve essere eseguito come root"
}
generate_password() {
  openssl rand -base64 32 | tr -d "=+/" | cut -c1-25
}
