---
tech: travis
title: Encrypting variables
tags: [travis]
sources:
  - name: Travis encryption documentation
    link: https://docs.travis-ci.com/user/encryption-keys/
---

# Encryption

Encryption ensures data integrity, security blabla etc. It has to be done per
repository i.e. the same data, such as a GitHub token, must be encrypted multiple
times

## Installation

Encryption is done via Travis CLI which is a Ruby gem:

```
gem install travis
```

Then login. Go to Github > Settings > Developper Settings > Personal access tokens.
Generate a new token and **make sure you save the token** as you will not see it again.
Full control over private repositories is required. Such authorisation cascades to
repositories status, deployment, public ones and invitations.

```
travis login --com --debug --debug-http --github-token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

I have not seen any difference between `--com` and `--pro`. Debugs are for my curiosity only.

- [Github auth token on Travis](https://blog.wyrihaximus.net/2015/09/github-auth-token-on-travis/)
- [By default, Travis CLI connects to .org](https://github.com/travis-ci/travis-ci/issues/10137)
- [Travis CLI requires scopes for GitHub token](https://github.com/travis-ci/travis.rb/issues/367)

## How to use

Encryption syntax is simple:

```
travis encrypt "Encrypted value here" --com -r {your repo}
```

Few words about it:

- "Encrypted value here" must contain exactly what you want o write in clear text.
  If you want to encrypt a variable, you will write `travis encrypt "GITHUB_TOKEN=MyTokenHere`.
- `--com` because I am using `travis.com` instead of `travis.org`
- `-r {repo}` to attach the encrypted value to a given repository such as `Al-un/learnzone`
- `--add path_to_destination` to append the encrypted value in your `.travis.yml`.
  I do not use this option because it breaks my configuration file formatting and
  manually add it to my `.travis.yml`
  To add a Slack notification, you can use `--add notifications.slack.room`

The encryption output looks like:

```yaml
secure: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA...AA
```

Copy everything to the proper destination. For example:

```yaml
env:
  global:
    # $GITHUB_TOKEN defined here
    secure: "AAAAAAAAAA..AAA"

notifications:
  slack:
    rooms:
      # Slack room "workspace:token" is defined here
      - secure: "AAAAAAAAAA..AAA"
```
