Lightweight orchestration toolkit for Percona, and Galera clusters. It provides clean, modular automation for deployment, conversion to cluster mode, monitoring, and secure management of your database infrastructure.

# Features
* 🚀 Simple MySQL Server installation
* 🔄 Convert standalone MySQL to Galera Cluster
* 📊 Cluster monitoring and health check
* 💾 Backup and restoration utilities
* 🔒 Automatic secure configuration
* 🎯 Easy-to-use command interface

# Quick Install
```bash
git clone https://github.com/ostap-mykhaylyak/tavros.git /opt/tavros
chmod +x /opt/tavros/main.sh
ln -s /opt/tavros/main.sh /usr/local/bin/tavros
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
