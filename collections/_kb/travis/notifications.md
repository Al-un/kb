---
tech: travis
title: Notifications
tags: [travis, notifications]
sources:
  - name: Travis notification documentation
    link: https://docs.travis-ci.com/user/notifications/
---

### Email

To turn off email notifications:

```yaml
notifications:
  email: false
```

### Slack

```yaml
notifications:
  slack:
    rooms:
      # secure version
      - secure: #...
      # non secure version
      - my-slack:THIS_IS_SOME_KEY#channel
    on_success: always
    on_failure: always
```

(Check when _dash_ or _no dash_ e.g. before `slack`)

To add the encrypt room:

```
travis encrypt "{Slack workspace name}:{Travis token in Slack}" --add notifications.slack.room -r Al-un/learn-zone-rails
```

The `--add notifications.slack.room` automatically appends the encrypted value(s) in
your `.travis.yml` but it breaks the file formatting T_T. Better remove it :)

> Depending on your travis configuration, you might need to add the `--com`
> argument.

- [Travis blog post on Slack](https://blog.travis-ci.com/2014-03-13-slack-notifications)
- [Setting up slack in Travis CI post](https://axdlog.com/2018/setting-up-slack-build-notification-in-travis-ci-for-github-project/)
