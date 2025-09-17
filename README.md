# tavros
Lightweight orchestration toolkit for Percona, and Galera clusters. It provides clean, modular automation for deployment, conversion to cluster mode, monitoring, and secure management of your database infrastructure.

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
