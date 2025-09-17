#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; PURPLE='\033[0;35m'; NC='\033[0m'

log()      { echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $*" ; }
error()    { echo -e "${RED}[ERROR]${NC} $*" >&2 ; exit 1 ; }
warning()  { echo -e "${YELLOW}[WARN]${NC} $*" ; }
info()     { echo -e "${BLUE}[INFO]${NC} $*" ; }
clusterlog(){ echo -e "${PURPLE}[CLUSTER]${NC} $*" ; }
