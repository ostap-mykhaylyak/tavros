check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "Questo script deve essere eseguito come root"
    fi
}

generate_password() {
    openssl rand -base64 32 | tr -d "=+/" | cut -c1-25
}

log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR $(date '+%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

cluster_log() {
    echo -e "${PURPLE}[CLUSTER]${NC} $1" | tee -a "$LOG_FILE"
}

init_environment() {
    # Creazione directory log e backup
    mkdir -p "$(dirname "$LOG_FILE")"
    mkdir -p "$BACKUP_DIR"
    
    # Generazione password se non esistenti
    if [[ -z "$SST_PASSWORD" ]]; then
        SST_PASSWORD=$(generate_password)
    fi
    
    if [[ -z "$MONITOR_PASSWORD" ]]; then
        MONITOR_PASSWORD=$(generate_password)
    fi
}

show_help() {
    echo -e "${GREEN}MySQL Server Orchestrator con supporto Galera Cluster${NC}"
    echo ""
    echo "UTILIZZO:"
    echo "  $0 <comando> [opzioni]"
    echo ""
    # ... resto dell'help
}
