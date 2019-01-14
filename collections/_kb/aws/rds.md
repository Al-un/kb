---
tech: aws
title: RDS
mentioned:
  - /2018/12/20/aws-journey
  - /2019/01/07/elastic-beanstalk-vs-ec2
---

AWS databases

## Setting up

Go to RDS dashboard page:

```
Services > Database > RDS
```

Hit the big orange `Create database` button

1. Select your database provider. I'll go with PostgreSQL. Make sure you check
   _Only enable options eligible for RDS Free Tiers_ if you are concerned by it
   Click _Next_
2. Select:

   - the database version
   - the instance supporting the database
   - allocated storage space
   - database identifier (URL prefix). If empty, no database will be instantiated
   - master username and password. **do not lose the info**

     Click _Next_

3. Configure your database:
   - Virtual Private Cloud: better use an existing one to regroup resources
   - Public accessibility: to be able to access the database from out of the VPC
   - Security group: up to you, you can create a new one or re-use an existing one
   - Database name and port
   - Other maintenance and stuff configuration
   - Uncheck "enable deletion protection" if you want to delete the database later
4. RDS instantiation is pretty long, please go take your coffee

## Post instantiation

### Surrounding resources

Creating a database will automatically create, if you decide to create it:

- a virtual private cloud (VPC) with a subnet group
- a security group

For a better readibility / maintenance / etc, feel free to give a proper name
to theses resources to know what is what.

### Database access

In the example of a PostgreSQL database, you can access the database via an url
`postgres://{username}:{password}@{hostname}:{port}/{database_name}`

- `username` refers to the master username you defined earlier
- `password` refers to the master password you defined earlier
- `hostname` is the _endpoint_: `{database identifier}.{shared unique id}.{aws region}.rds.amazoneaws.com`
- `port` could have been defined. Default is 5432 for PostgreSQL
- `database_name` according to your definition

### Security

In case you have a strict security group, ensure that the appropriate EC2 instances
have access to your database. In the example of PostgreSQL:

| Type       | Protocol | Port range | Source                       | Description                           |
| ---------- | -------- | ---------- | ---------------------------- | ------------------------------------- |
| PostgreSQL | TCP      | 5432       | Custom: {Some IP Address}/32 | Authorization per IP address          |
| PostgreSQL | TCP      | 5432       | Custom: sg-1234567893        | Authorization per security group name |
