---
title: Starting with Vue
tags: [vue, router, state management, linter, scss]
articles:
  - _kb/vue/routing.md
  - _kb/vue/vuex.md
---

### Using console

Console raises an eslint error. To remove it, fix in `package.json`:

```json
"eslintConfig": {
  "rules": {
    "no-console": "off"
  },
}
```

### Router

Starting to route with `vue-router`:

```javascript
// src/router.js
import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
  routes: [{ path: "/", name: "home", component: MyComponent }]
});
```

Rendering of routing is done with `<router-view />` while navigation links are
`<router-link></router-link>`. To add [active style](https://router.vuejs.org/api/#active-class):

```javascript
// src/components/layout/SideMenu.vue
<router-link class="list-group-item" active-class="active" to="/catalogs">
  Catalogs
</router-link>
```

By default, Vue router is a Hash router. To keep history/switch to browser router,
use the [`history` mode](https://router.vuejs.org/guide/essentials/history-mode.html)

### Styling

#### Bootstrap

Just adding [`yarn add bootstrap-vue`](https://bootstrap-vue.js.org/docs)

#### SCSS

Because SCSS is copied from other learnzones, it is all stored in the `src/assets`
folder. SCSS main file is then imported in `main.js`:

```javascript
// src/main.js
import "./assets/stylesheets/application.scss";
```

Source is [Reddit](https://www.reddit.com/r/vuejs/comments/611fd2/how_can_i_import_scss_globally/)

#### ???

For some reasons, later, `sass-loader` and `node-sass` were required:

```shell
yarn add sass-loader
yarn add node-sass
```

### State management

So far, we have an empty canvas, kind of navigations rules. Time to fetch data
from a backend. Redux is not bad for React, so how Vue handles state? It appears
that it is aimed at getting along with [Vuex](https://vuex.vuejs.org/)

Following stuff are from Vuex:

- `this.$dispatch('my-action');`

Following features were tested:

- synchronous and asynchronous state changes
- modules
- custom values computed from state values

### Webpack configuration

webpack configuration is moved to `vue.config.js`:

- [StackOverflow](https://stackoverflow.com/questions/41955331/specify-a-root-path-for-imports)
- [Webpack documentation for alias](https://router.vuejs.org/guide/essentials/redirect-and-alias.html)

### Loading

Simply use a flag and the `v-show` conditional rendering
