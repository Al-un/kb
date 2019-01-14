---
tech: javascript
title: Workbox
---

## Installation

> `importScripts` must run in the context of the service worker and not the main
> JavaScript thread. Consequently, if using webpack, do **not** import the
> service worker file
> Defined as [an issue here](https://github.com/Al-un/workbox/issues/1) and
> solving is from [this issue](https://github.com/GoogleChromeLabs/sw-precache/issues/307#issuecomment-306507753)

## PWA

https://codelabs.developers.google.com/codelabs/workbox-lab

First thing is to generate a manifest file. A way to do it is to use
[`workbox-cli`](https://developers.google.com/web/tools/workbox/guides/generate-service-worker/cli)

Workbox-cli does not work so I use this _workbox-config.js_:

```js
module.exports = {
  globDirectory: "build/",
  globPatterns: [
    "**/*.css",
    "index.html",
    "js/animation.js",
    "images/home/*.jpg",
    "images/icon/*.svg"
  ],
  swSrc: "src/sw.js",
  swDest: "build/sw.js",
  globIgnores: ["../workbox-config.js"]
};
```
