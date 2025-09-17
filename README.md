Lightweight orchestration toolkit for Percona, and Galera clusters. It provides clean, modular automation for deployment, conversion to cluster mode, monitoring, and secure management of your database infrastructure.

## Features
* 🚀 Simple MySQL Server installation
* 🔄 Convert standalone MySQL to Galera Cluster
* 📊 Cluster monitoring and health check
* 💾 Backup and restoration utilities
* 🔒 Automatic secure configuration
* 🎯 Easy-to-use command interface

## Quick Install
```bash
git clone https://github.com/ostap-mykhaylyak/tavros.git /opt/tavros
chmod +x /opt/tavros/main.sh
ln -s /opt/tavros/main.sh /usr/local/bin/tavros
```

## Updating
```bash
cd /opt/tavros
git pull
```

## Examples
```bash
# Install MySQL with a custom root password
tavros install mysecurepassword123

# Convert to cluster with node name and IP
tavros convert-to-cluster node1 192.168.1.10

# Add a node to an existing cluster
tavros add-node node2 192.168.1.11 "192.168.1.10,192.168.1.11"

# Backup all databases
tavros backup all

# Check cluster health
tavros cluster-health
```

```
tavros/
│── main.sh
│── config.sh
│
│── utils/
│   ├── logging.sh
│   ├── common.sh
│   └── maintenance.sh
│
│── percona/
│   ├── install.sh
│   ├── config.sh
│   ├── secure.sh
│   ├── monitor.sh
│   └── users.sh
│
│── cluster/
│   ├── install.sh
│   ├── convert.sh
│   ├── manage.sh
│   ├── monitor.sh
│   └── ssl.sh
│
└── backup/
    ├── xtrabackup.sh
    └── logical.sh
```
