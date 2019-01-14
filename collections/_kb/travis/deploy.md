---
tech: travis
title: Deployment
tags: [travis, deploy]
mentioned:
  - /2019/01/03/pwa-with-vue
sources:
  - name: Travis deployment documentation
    link: https://docs.travis-ci.com/user/deployment/
---

## Deployment configuration

### Conditional deployment

> By default, deployment only occurs to `master` or application specific branch
> To have deployments on multiple branches per deployment provider/script,
> ensure that conditional deployment is properly configured

Basic condition is

```yaml
deploy:
  - provider: some_provider
    # deployment providers and stuff here
    on:
      branch: master # master deployment
  - provider: another_provider
    # other stuffs
    on:
      branch: develop # develop deployment
```

To have all multiples branches, use the `all_branches` conditions restricted by
other conditions.

```yaml
deploy:
  # ...
  on:
    all_branches: true
    condition: some_condition_here
```

## Deployment providers

### Github pages

Travis provides support for [Github pages deployment](https://docs.travis-ci.com/user/deployment/pages/).
Configuration is dead simple:

```yaml
deploy:
  # Github pages provider
  provider: pages
  # Keep built artifacts
  skip-cleanup: true
  # Encrypted or secured environment variable
  github-token: $GITHUB_TOKEN
  # Not using git push --force
  keep-history: true
  # restricted branch
  on:
    branch: master
```
