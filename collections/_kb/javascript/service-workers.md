---
tech: javascript
title: Service Workers
mentioned:
    - /2018/12/14/service-workers
---

## Registration

From [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/ServiceWorkerContainer/register)

```javascript
if (navigator.serviceWorker) {
  log("Service Worker is trying to register");
  navigator.serviceWorker
    .register("./service-worker.js", { scope: "./" })
    .then(registration => console.log(registration))
    .catch(err => console.(err));
} else {
  log("Service Worker is not supported in this browser", "Error");
}
```

- registration scope is relative to current file location
- service worker file location is relative to current file location
- `err` cannot be JSON.stringify
- registration is an object

> - service worker files must be properly referenced
> - beware of service worker scope

## Installation

SW are fully event based. Installation and activation are event among many others.
To catch such event, append event listeners:

```javascript
self.addEventListener("install", event => {
  log(event);
});
```

Available events are

![Service workers event](https://mdn.mozillademos.org/files/12632/sw-events.png)

- `install`
- `activate`
- `message`
- `fetch`
- `sync`
- `push`

<sub>The `self` quoted references [`window.self`](https://www.w3schools.com/jsref/prop_win_self.asp).</sub>

> - service workers do not have access to DOM!

## Caching

```javascript
self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_VERSION).then(cache => {
      log(`Opening cache version ${CACHE_VERSION}`);
      return cache.addAll(CACHE_FILES);
    })
  );
});
```

`CACHE_VERSION` is a simple string while `CACHE_FILES` is an array of files path to be cached.
