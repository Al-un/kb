---
title: aws journey
articles:
  - _kb/aws/ec2.md
  - _kb/aws/eb.md
  - _kb/aws/rds.md
---

Starting to sails toward AWS with Rails.

## EB

- Install EB CLI
- Configure application with `eb init`
- Deploy with `eb deploy`

## RDS

Setting up an RDS from an ELB:
https://docs.aws.amazon.com/quickstarts/latest/webapp/expanding-environments.html?icmpid=docs_eb_console_new#expanding-environments-rds

Setting up an RDS independently:
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.PostgreSQL.html

Add temporary environment variable in PowerShell
https://serverfault.com/questions/349585/how-do-i-set-an-environmental-variable-from-a-powershell-command

Then run `db:migrate` from local powershell to update production database

> Do not forget to grant access to your RDS from EB / EC2!

## EC2

- [Main tuto](https://www.awsrails.com/rails-ec2/)
- [Convert OpenSSH private key to Putty private key](https://unix.stackexchange.com/questions/116303/convert-amazon-pem-key-to-putty-ppk-key-linux)

## CircleCI

1. Create a CircleCI user in AWS IAM
2. Copy keys (access key and secret access key) into repository settings in CircleCI
3. Use `eb deploy {app name}`

- Ensure that apt-get are automatic with `-y`
- Ensure that elasticbeanstalk profiles are in the repository:
  ```
  ERROR: This directory has not been set up with the EB CLI
  You must first run "eb init".
  Exited with code 126
  ```

sources:

- https://discuss.circleci.com/t/best-way-to-auto-deploy-to-elastic-beanstalk/382/2
- CircleCI 1.0: https://gist.github.com/RobertoSchneiders/9e0e73e836a80d53a21e
- CircleCI 2.0: https://gist.github.com/ryansimms/808214137d219be649e010a07af44bad
- AWS credentials https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-configuration.html
