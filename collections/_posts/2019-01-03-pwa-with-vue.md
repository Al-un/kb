---
title: pwa with vue
articles:
  - _kb/vue/pwa.md
  - _kb/vue/routing.md
  - _kb/travis/deploy.md
---

Browsing the service workers universe in Vue.js...

### PWA Plugin

Adding ServiceWorkers mainly relies on the PWA plugin of Vue. It works above
Workbox.

One of PWA requirements is having all URLs returning a 200 HTTP status. Before
all that, I had to fix a Vue routing issue with `BaseUrl`.

### Travis

When trying to deploy a feature branch, I had the error

```shell
Skipping a deployment with the pages provider because this branch is not permitted: feature/sw
```
