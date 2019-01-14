---
tech: circleci
title: Configuration
tags: [circleci]
sources:
---

# Configuration

Configuration involves:

- platform used to execute task
- third party
- environment variables

## Execution environment

CircleCI relies on CircleCI's Docker images ([documentation](https://circleci.com/docs/2.0/circleci-images/#section=configuration))
which is mainly used as follow:

```yaml
jobs:
  build-job:
    docker: # executor type
      - image: buildpack-deps:trusty # primary container will run Ubuntu Trusty
```

### Executors

> Executors require version 2.1

When the same environment is required multiple times or for code organization purpose,
you can configure the execution environment under [`executors`](https://circleci.com/docs/2.0/configuration-reference/#executors-requires-version-21):

```yaml
version: 2.1

executors:
  # Define environment like you did in jobs
  app-builder:
    docker:
      - image: circleci/ruby:2.5.1-node-browsers
      - image: circleci/postgres:9.6.5-alpine-ram
    working_directory: ~/repo
  aws-deployer:
    docker:
      - image: circleci/python:3.7.2-stretch-node-browsers-legacy

jobs:
  build:
    executor: app-builder
    steps: # steps
  deploy-dev:
    executor: aws-deployer
    steps: # steps
  deploy-prod:
    executor: aws-deployer
    steps: # steps
```

- [Reusable executors documentation](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-executors)

### Orbs

> Orbs require version 2.1

[CircleCI Orbs](https://circleci.com/docs/2.0/using-orbs/#section=configuration) are
presets used as _third party library_. It offers preconfigured commands. For
example, the [Slack Orb](https://github.com/CircleCI-Public/slack-orb) is used as
follow:

```yaml
version: 2.1

orbs:
  slack: circleci/slack@1.0.0

jobs:
  # This job only push a message on Slack to request an approval
  before_approval:
    docker:
      - image: buildpack-deps:trusty # Ubuntu Trusty
    steps:
      - slack/notify:
          message: "A deploy is on hold for a manual approval: https://circleci.com/workflow-run/$CIRCLE_WORKFLOW_ID"
          mentions: "{validator users}"
          color: "#e5bd0b"
          # Optional: Enter a specific webhook here or the default will use $SLACK_WEBHOOK
          # webhook: 'webhook'
```

- [CircleCI Orbs registry](https://circleci.com/orbs/registry/)
- [Orbs FAQ](https://circleci.com/docs/2.0/orbs-faq/#section=configuration)

## Commands

> Commands require version 2.1

If a command pattern is repeated, it can be defined under `commands` with parameters

```yaml
version: 2.1

commands:
  deploy-aws-eb:
    description: "Deploy to AWS Elastic Beanstalk"
    parameters:
      env:
        type: string
    steps:
      - run:
          # Environment is assumed to by Python
          name: Install EB CLI
          command: sudo pip install awsebcli --upgrade
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
          name: Deploy to AWS EB (Prod)
          command: eb deploy << parameters.env >> --profile eb-cli --label << parameters.env >>-$CIRCLE_BUILD_NUM

jobs:
  # Deploy to dev
  deploy-dev:
    executor: aws-deployer
    steps:
      - checkout
      - deploy-aws-eb:
          env: learnzone-aws-dev

  # Deploy to prod
  deploy-prod:
    executor: aws-deployer
    steps:
      - checkout
      - deploy-aws-eb:
          env: learnzone-aws
```

- [`commands` syntax](https://circleci.com/docs/2.0/configuration-reference/#commands-requires-version-21)
- [Reusable commands documentation](https://circleci.com/docs/2.0/reusing-config/)
