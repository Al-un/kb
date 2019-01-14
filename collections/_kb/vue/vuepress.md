---
tech: vue
title: Vuepress
mentioned:
  - /2019/01/06/testing-vuepress
---

## Installation

```
yarn global --dev add vuepress@next
```

`@next` specifies the new version. As-of January 2019, it refers to 1.x version
which is still is alpha stage. If more convenient, `vuepress` can globally be
installed.

### Scripts

```json
  "scripts": {
    "serve": "vuepress dev --port 3000",
    "build": "vuepress build"
  }
```

- Running on port 3000 to align with other `serve`
- With yarn you can omit `run` with both scripts. Respectively `yarn serve` and `yarn build`

## Theme

Start a custom theme by creating a `.vuepress/theme/Layout.vue` file. As
_Convention is over configuration_, the main layout file must be named `Layout.vue`.
If you are using _SCSS_, do not forget to `yarn add --dev sass-loader`.

```html
<template>
  <div>
    <nav>
      <router-link to="/">Home</router-link>
      <router-link to="/about.html">About</router-link>
    </nav>

    <main>
      <Content/>
    </main>
  </div>
</template>

<style lang="scss" scoped>
</style>
```

Cool things:

- It's a Vue component! Design your layout with a standard SFC (Single File Component)
- Altough it looks a bit hacky, you can use [Bootstrap-Vue](https://bootstrap-vue.js.org/docs) with:
  ```javascript
  <script>
    import Vue from "vue";
    import BootstrapVue from "bootstrap-vue";
    import "bootstrap/dist/css/bootstrap.css";
    import "bootstrap-vue/dist/bootstrap-vue.css";

    Vue.use(BootstrapVue);

    export default {};
  </script>
  ```
  in your Layout.vue