---
tech: heroku
title: CLI
mentioned:
---

## App

List applications

```sh
heroku apps
# or
heroku list
```

### Create an app

```sh
heroku create pouet-cli
Creating ⬢ pouet-cli... done
https://pouet-cli.herokuapp.com/ | https://git.heroku.com/pouet-cli.git
```

`create` is an alias. Real command is:

```sh
heroku apps:create pouet-cli
# specific region
heroku apps:create pouet-cli --region eu
```

### Deploy

To deploy a sub folder on Heroku:

```sh
git subtree push --prefix rails/api heroku-rails-api master
```

with heroku-rails-api, the remote connected to the heroku app git repository. In case of fast-forward merge issues, force push with:

```sh
git push heroku-rails-api `git subtree split --prefix rails/api/ master`:master --force
```

The error is

```sh
git push using:  heroku-rails-api master
To https://git.heroku.com/learn-rails-api.git
 ! [rejected]        42ec0434bb179af1e134ab73ba852922e92294b9 -> master (non-fast-forward)
error: failed to push some refs to '{git address}
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Source:

    https://coderwall.com/p/ssxp5q/heroku-deployment-without-the-app-being-at-the-repo-root-in-a-subfolder
    https://stackoverflow.com/questions/13756055/git-subtree-subtree-up-to-date-but-cant-push

### Delete an app

```sh
heroku apps:destroy pouet-cli
```

## PostgreSQL

### Add DB

```sh
heroku addons:create heroku-postgresql:<PLAN_NAME>
#e.g.
heroku addons:create heroku-postgresql:hobby-dev
# with specific version
heroku addons:create heroku-postgresql:hobby-dev --version=9.4
# complete instruction with specific name
heroku addons:create heroku-postgresql:hobby-dev --app=pouet-cli --name=pouet-db --version=9.4
```

Confirm add-on creation by showing its info:

```sh
heroku addons:info pouet-db
```

Connect to DB and check version:

```sh
al-un@al-un: $psql postgres://{username}:{password}@{host}:{port}/{db_name}

dcs0b93s4mtkaf=> SELECT VERSION();
                                                                     version
-------------------------------------------------------------------------------------------------------------------------------------------------
 PostgreSQL 9.4.20 on x86_64-pc-linux-gnu (Ubuntu 9.4.20-1.pgdg16.04+1), compiled by gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609, 64-bit
(1 row)
```

Or

```sh
heroku pg:info --app pouet-cli
```

### Upgrade DB

Check if data checksum is enabled:

```sql
SELECT setting = 'on' AS enabled FROM pg_settings WHERE name = 'data_checksums';
```

Global idea is:

- create a buffer database
- copy data from source to buffer database
- enable maintenance mode (no data writing on source database)
- upgrade buffer database
- promote buffer database
- delete source database
- disable maintenance mode

### Delete DB

```sh
heroku addons:destroy <addon-name>
#e.g.
heroku addons:destroy postgresql-globular-47424
```

## Multiple accounts

https://github.com/heroku/heroku-accounts

```sh
heroku accounts:add perso
```
