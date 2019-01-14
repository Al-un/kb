---
tech: vue
title: Vuex
tags: [vue, state management]
sources:
  - name: Vuex documentaiton
    link: https://vuex.vuejs.org/
mentioned:
  - /2018/12/16/starting-vuejs
---

Similar to Redux, Vuex advocates the single point of truth approach. State is
immutabled and, similarly to Redux, should be changed by pure functions

> TODO: check if really pure functions or impure is OK

## Global access

To avoid importing store in all components, add at the root components:

```javascript
// in some App.vue > script
import store from "./store";
export default {
  name: "app",
  // provide the store using the "store" option.
  // this will inject the store instance to all child components.
  store
};
```

Store is then access via `$store`. To avoid complex mapping, use `mapState`:

```javascript
// in some components > script
export default {
  name: "some-component",
  computed: {
    // option 1: directly fetching from store
    productsFromStore() {
      return this.$store.state.products;
    },
    // option 2: use `mapState`
    ...mapState({
      products: state => state.products
    })
  }
};
```

Notice that [spread syntax](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Spread_syntax) is used.

## Actions and mutations

> **Synchronous**: use `mutations` directly
> **Asynchronous**: use `actions` to commit `mutations`

State changes are triggered by committed mutations:

```javascript
// In some component method
// this will trigger a synchronous changes
this.$state.commit("addProduct", product);
// Somewhere lese
this.$state.dispatch("asyncAddOrder", order);

// In some store.js
const store = new Vuex.Store({
  state:{
      orders: [],
      products: []
  }
  actions: {
      asyncAddOrder({commit}, order){
          placingOrdering(orderin).then((placedOrder) => {
              commit('addOrder', placedOrder);
          })

      },
      // OR await FTW:
      asyncAddOrder: async ({commit}, order) => {
          const placedOrder = await placingOrdering(order);
          commit('addOrder', placedOrder);
      }
  },
  mutations: {
    addProduct(state, product) {
      // do some stuff
    }
    addOrder(state, order){
      // do some stuff
    }
  }
});
```

In this example:

- `addProduct` is done synchronously
- `addOrder` is done asynchronously. [`destructing`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)
  syntax is used for `{commit}` instead of `store` to avoid spamming `store.commit`

## Getters

Store can also provide getters for computed values (filtering, miscellaneous
computing...). Refer to documentation

## Modules

Like Redux/Saga, Vuex can be modular with the `modules` attribute:

Consider a catalog module:

```javascript
// src/store/modules/catalog.js
import API from "../api";

const state = {
  list: [], // catalogs list
  entity: {} // single displayed or edited catalog
};

const actions = {
  list_load: async ({ commit }) => {
    const catalogs = await API.get("/catalogs");
    commit("list_loaded");
  }
};

const mutations = {
  list_loaded: (state, list) => {
    state.list = list;
  }
};

export default {
  namespaced: true,
  state,
  actions,
  mutations
};
```

Such module can be imported in the root store:

```javascript
// src/store/index.js
import Vue from "vue";
import Vuex from "vuex";
import catalogs from "./modules/catalog";

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    catalogs
  }
});

export default store;
```

As `namespaced: true` is specified in _catalog_ module, `list_load` action is not
recognised and has to be prepended with the namespace: `catalog/list_load`.
Namespace is defined by the name used to import the module.
