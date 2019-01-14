---
tech: aws
title: EC2
mentioned:
  - /2018/12/20/aws-journey
    - /2019/01/07/elastic-beanstalk-vs-ec2
---

## Setting up

The EC2 setting up is pretty straight forward as you set up a standard virtual
machine. Just follow the wizard and you will have a brand new VM on your hands.

Focus should be on

- SSH key pair (to be able to connect to it)
- Assigned security group should allow HTTP from anywhere and SSH from your IP address only

## Installation (Rails example)

- Start with the first of all:
  ```sh
  sudo apt-get update
  ```
- Install Ruby. I was going the RVM route
  - https://gorails.com/setup/ubuntu/18.04
  - https://www.howtoforge.com/tutorial/ubuntu-ruby-on-rails/
- Install Rails via a simple `gem install rails`
- PostgreSQL `pg` gem is a [bit tricky](https://www.digitalocean.com/community/questions/gem-install-pg-not-working):
  ```sh
  sudo apt-get install postgresql-client libpq5 libpq-dev
  sudo gem install pg
  ```
- As a non-root user, we cannot use the 80 port (any port below 1024 actually). Trick
  is to use port forward from 80 to 3000
  1. `sudo ufw enable` => enable firewall
  2. `sudo ufw allow http`
  3. `sudo ufw allow https`
  4. `sudo ufw allow ssh` **do not forget this one**
  5. Proceed to [port forwarding](https://askubuntu.com/a/661003)
- Run the Rails application with puma as usual to check if it works

## Deployment and long server run

That's the good two cents question as-of January 2019
