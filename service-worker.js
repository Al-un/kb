/**
 * As-of 14-Jan-2019, this is not used
 */

importScripts(
  "https://storage.googleapis.com/workbox-cdn/releases/3.6.1/workbox-sw.js"
);

/**
 * Configure workbox for this project
 * Jekyll specific
 * https://github.com/lavas-project/jekyll-pwa
 */
const configureWorkbox = () => {
  // Global config?
  workbox.setConfig({
    // Force development build even in production
    // debug: true
  });

  // Cache naming
  workbox.core.setCacheNameDetails({
    prefix: "kb",
    suffix: "v1"
  });

  // let Service Worker take control of pages ASAP
  workbox.skipWaiting();
  workbox.clientsClaim();

  // Log level
  workbox.core.setLogLevel(workbox.core.LOG_LEVELS.debug);
};

/**
 * Define cached objects
 */
const setWorkboxCaching = () => {
  // let Workbox handle our precache list
  workbox.precaching.precacheAndRoute(self.__precacheManifest);

  // use `networkFirst` strategy for `*.html`, like all my posts
  // workbox.routing.registerRoute(/\.html$/, workbox.strategies.networkFirst());
};

if (workbox) {
  console.log(`Yay! Workbox is loaded 🎉`);
  configureWorkbox();
  setWorkboxCaching();
} else {
  console.log(`Boo! Workbox didn't load 😬`);
}
