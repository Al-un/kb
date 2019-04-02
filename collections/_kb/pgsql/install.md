---
tech: pgsql
title: Installation
---

## Install

Add PostgreSQL APT:

```sh
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
```

Install

```sh
sudo apt-get install postgresql-11
```

Source: <https://www.postgresql.org/download/linux/ubuntu/>

## Upgrade

> Knowledge about PostgreSQL cluster is required

Let's assume we want to migrate from 9.6 to 11.x on a Ubuntu server. As
PostgreSQL 9.6 already exists, it is assumed that `/etc/apt/sources.list.d/pgdg.list`
is already configured.

Install target version. Usually, this is enough as it installs the latest version:

```sh
sudo apt-get upgrade postgresql
```

Two clusters now coexist:

```sh
ubuntu@ip-172-31-42-106:~$ pg_lsclusters
Ver Cluster Port Status Owner    Data directory               Log file
9.4 main    5432 online postgres /var/lib/postgresql/9.4/main /var/log/postgresql/postgresql-9.4-main.log
11  main    5433 online postgres /var/lib/postgresql/11/main  /var/log/postgresql/postgresql-11-main.log
```

PostgreSQL service can be stopped during the migration but if we don't,
PostgreSQL utilities properly shut down the clusters and restart it

Renaming the 11.x cluster to avoid conflict:

```sh
ubuntu@ip-172-31-42-106:~$ sudo pg_renamecluster 11 main main_pristine
Stopping cluster 11 main ...
Starting cluster 11 main_pristine ...
```

Upgrade main cluster:

```sh
sudo pg_upgradecluster 9.4 main
```

There are now three clusters:

```sh
ubuntu@ip-172-31-42-106:~$ pg_lsclusters
Ver Cluster       Port Status Owner    Data directory                       Log file
9.4 main          5434 down   postgres /var/lib/postgresql/9.4/main         /var/log/postgresql/postgresql-9.4-main.log
11  main          5432 online postgres /var/lib/postgresql/11/main          /var/log/postgresql/postgresql-11-main.log
11  main_pristine 5433 online postgres /var/lib/postgresql/11/main_pristine /var/log/postgresql/postgresql-11-main_pristine.log
```

We can now safely delete the unused clusters:

```sh
sudo pg_dropcluster 9.4 main
sudo pg_dropcluster 11 main_pristine --stop
```

`--stop` is required for 11.x cluster because it was still running.

check with `psql --version` and `SELECT VERSION();`

Resources:

- <https://www.postgresql.org/docs/current/upgrading.html>
- <https://gorails.com/guides/upgrading-postgresql-version-on-ubuntu-server>
- <https://wiki.postgresql.org/wiki/Using_pg_upgrade_on_Ubuntu/Debian>

## Cluster

### Change data directory

Stop postgresql service

```sh
sudo systemctl stop postgresql
```

Synchronize source and target directory

```sh
sudo rsync -av /var/lib/postgresql/11 /home/al-un/db/pg/11
```

Rename source directory

```sh
sudo mv /var/lib/postgresql/11/main /var/lib/postgresql/11/main.bak
```

Update configuration

```sh
sudo vim /etc/postgresql/11/main/postgresql.conf
```

Start

Source: <https://www.digitalocean.com/community/tutorials/how-to-move-a-postgresql-data-directory-to-a-new-location-on-ubuntu-16-04>
