---
title:
articles:
  - _kb/javascript/service-workers.md
---

Testing service workers with resources:

- [Sitepoint](https://www.sitepoint.com/getting-started-with-service-workers/)
- [Developers.Google](https://developers.google.com/web/fundamentals/primers/service-workers/)

## Registering

Attempt to register service workers but if the service worker file is missing,
following error appears:

```
Failed to register/update a ServiceWorker for scope ‘https://al-un.github.io/service-worker/’: Load failed with status 404 for script ‘https://al-un.github.io/service-worker/service-worker.js’.
```

Message is clear: sw file must be present !

Next step is to trigger the basic lifecyle: `install`, `activate` and `fetch`.

## Caching

Following Sitepoint guide, let's try caching some content. In my [service-worker](https://github.com/Al-un/service-worker)
repo, I tried to cache the website to make it available offline except one picture.

By updating the `activate` and `fetch` events:

- It works on Chrome but not on Firefox
- Miku picture is properly cached but Luka picture is cached as well when it should not be

I browsed a bit [`CacheStorage` documentation](https://developer.mozilla.org/en-US/docs/Web/API/CacheStorage)
and try to implement a manual cache clear.

Well...fcuk. I have `disable cache` option enabled in Firefox debugging (Network tab).
