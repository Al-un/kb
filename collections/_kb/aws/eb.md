---
tech: aws
title: Elastic Beanstalk
mentioned:
  - /2018/12/20/aws-journey
  - /2019/01/07/elastic-beanstalk-vs-ec2
---

Elastic Beanstalk comes up with a CLI

## Setting up

Go to EB dashboard page:

```
Services > Compute > Elastic Beanstalk
```

### Application

Create an application. An application can contain multiple environment reflecting
the environment stage of your application. This also allows awesome features such
as URL swapping (pre-production swapping with production)

Click `Create New Application` on the top right and give it an appropriate name

Such application will have three tabs on the left:

- Environments list (terminated environments disappear after a while)
- Uploaded application versions. You can restore a past deployment from here.
  Versions are stored in the Elastic Beanstalk S3 instance under a folder named
  after your application
- Environments configurations list

### Environment

Create an environment and select the `Web server environment`.

#### Basic configuration

Select an appropriate environment name reflecting the environment stag and a subdomain
if available.

Select the platform depending on your application technology.

For now, let's start with a sample application. The web application will be uploaded
later

Leave the additional aside and hit "Create environment". Please wait for a while.
Meanwhile, you can jump into the RDS configuration (_please check the RDS page_)

At this stage, you have a beautiful landing page

#### Extra configuration

When your environment is ready, time to set up some extra configuration. So far
it mainly involves environment variables, especially if your application relies
on it for connecting to the database

## EB CLI

Some CLI utilities to handle AWS Elastic Beanstalk. Cool thing is that it can be
done on your local machine as well as some Continuous Development tool

### Installation

Install EB CLI ([documentation](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html?icmpid=docs_elasticbeanstalk_console#eb-cli3-install.cli-only)):

- Install via Python (here using Python 3+)
  ```sh
  python3 -m pip install awsebcli --upgrade --cli
  ```
- Add the user relative script folder to environment variable:
  - Something like `%USERPROFILE%\AppData\Roaming\Python\Python36\Scripts` on Windows
- Check that CLI is available from terminal:
  ```sh
  eb --version
  ```
- Create an user via _AWS IAM_ to get a _aws access id_ and a _aws secret key_
- [Initialize](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-configuration.html)
  the application if it does not exist yet
- To list all environments
  ```sh
  eb list
  ```
- To deploy code to an environment
  ```sh
  eb deploy {environment name}
  ```
- To terminate environment
  ```sh
  eb delete {environment name}
  ```

### Usage

Most of the action done via the management console can be done via EB CLI. To start:

```sh
cd path_to_your_application_repository
eb init
```

1. Select your region
2. If your application already exists, select it to "link" the repository to the application
3. Select the default existing environment. You can change it via
   ```sh
   eb use {new default environment name}
   ```

This will generate a `.elasticbeanstalk/config.yml`. Feel free to have a look and
adapt the content if necessary

To deploy the current code:

```sh
eb deploy {environment name}
```

_Environment name_ is optional. If omitted, deployment will be done to the selected
default environment

> Do not forget to assign appropriate environment variables (Rails secrey key,
> database url, third party configuration, etc)

Read [more on `eb deploy`](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb3-deploy.html)

#### Git branches

> To be confirmed, tested blabla

The EB CLI seems to deploy the currently active git branch. Example:

- You are currently on the _develop_ branch
- You have two environment: _prod_ and _dev_
- If you `eb deploy prod`, you will deploy your _develop_ to your _prod_ environment

#### Ruby on Rails

for Ruby, do not forget:

- SECRET_KEY_API
- DATABASE_URL

If you cannot multiple Ruby version, make sure that Ruby sub-version
(e.g. _2.5.1_ vs _2.5.3_) does not prevent from deploying
