---
tech: circleci
title: AWS
tags: [circleci, deploy]
sources:
mentioned:
  - /2018/12/20/aws-journey
  - /2019/01/07/elastic-beanstalk-vs-ec2
---

> For some reason, credentials should be declared quite manually

## Elastic Beanstalk

### Script

CircleCI will leverage EB CLI. Add a deploy job in your workflow:

```yaml
workflows:
  version: 2
  # Staging deployment
  build-deploy:
    jobs:
      - build
      - deploy:
          requires:
            - build

jobs:
  build: # build definition
  deploy:
    docker:
      # not requiring a specific stack
      - image: buildpack-deps:trusty
    steps:
      # Need to checkout not only the code but also the EB configuration
      - checkout
      # EB CLI
      - run:
          name: Install EB CLI
          command: |
            sudo apt-get -y update
            sudo apt-get -y install python-pip python-dev build-essential
            sudo pip install awsebcli --upgrade
      # Problem here
      - run:
          name: Create AWS credentials manually
          command: |
            mkdir ~/.aws
            touch ~/.aws/config
            chmod 600 ~/.aws/config
            echo "[profile eb-cli]" > ~/.aws/config
            echo "aws_access_key_id=$AWS_ACCESS_KEY_ID" >> ~/.aws/config
            echo "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" >> ~/.aws/config
      - run:
          name: Deploy to AWS EB
          command: eb deploy {target environment} --profile eb-cli
```

- I did not find a better solution than create a [AWS config file](https://github.com/kgoedecke/circleci-beanstalk-example/blob/master/.circleci/config.yml)

### Troubleshooting

In case of

```
ERROR: This directory has not been set up with the EB CLI
You must first run "eb init".
Exited with code 126
```

Ensure that you have elastic beanstalk profiles in the `.elasticbeanstalk/config.yml`
