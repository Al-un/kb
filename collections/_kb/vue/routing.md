---
tech: vue
title: Routing
tags: [vue, router]
sources:
  - name: Vue Router documentaiton
    link: https://router.vuejs.org/
mentioned:
  - /2018/12/16/starting-vuejs
  - /2019/01/03/pwa-with-vue
---

### Navigation

To render routed view:

```html
<main id="myApp"><router-view /></main>
```

To generate navigation links:

```javascript
// src/components/layout/SideMenu.vue
<router-link class="list-group-item" active-class="active" to="/catalogs">
  Catalogs
</router-link>
```

### Browser routing vs Hash routing

By default, Vue router uses a Hash routing such as `mysite.com/#/myroute`. This
can raise issue when bookmark and history are involved. To use browser routing,
use the _history_ mode:

```javascript
// src/routes/index.js

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    // paths here
  ]
});
```

### Base url

In case of browsing routing, most of deployment handles the simple case: when
`baseUrl` equals to the root URL `/`.

However, if it is not the case, the `base` options is required. Usually, it
uses the import from `vue.config`:

```javascript
// src/routes/index.js
import { baseUrl } from "../../vue.config";

export default new Router({
  mode: "history",
  base: baseUrl,
  // routes defintions
  routes: []
});
```

Sources:

- [base option documentation](https://router.vuejs.org/api/#base)
