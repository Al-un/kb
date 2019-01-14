---
tech: react
title: Redux
tags: [react, redux]
sources:
  - name: Redux documentation for React
    link: https://redux.js.org/basics/usage-with-react
---

To have a single point of truth for our data: the Redux state.

```
yarn add redux
yarn add react-redux
```

Event flow looks like:

- A UI action is triggered by the user
- This UI action generates and dispatches an _action_
- This _action_ is caught by Redux
- The _action_ is processed by the reducer
- Redux state is updated
- Impacted components are updated if their `props` depends on Redux state

## Redux Higher order component: `connect`

```javascript
import { connect } from 'react-redux';

// Articles list props depending on Redux state
const mapStateToProps = state => ({ entities: state.articles.list });

// Article list can trigger following events:
// - on component mounting, it "loads" articles which will update `state.articles.list`
// - on delete button click, it "deletes" the appropriate article
const mapDispatchToProps = dispatch => {
  return {
    load: () => dispatch(loadArticles()),
    delete: id => dispatch(deleteArticle(id))
  };
};

// Order matter. If only `mapDispatchToProps` is defined, `connect` requires a 
// `null` first argument
const ArticlesContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(ArticleList);
```

## Reducers

The key used in `combinedReducers` is used to define keys in store. Given

```javascript
combineReducers({
  article: articleReducer,
  catalog: catalogReducer
});
```

and for example, in catalog reducers, state is updated as:

```javascript
export default function reducer(state = {}, action = {}) {
  return { ...state, list: catalogsList };
}
```

Catalogs list is not access via `store.catalogs` but `store.catalogs.list`. Articles
list behave similarly

## Ducks

Instead of splitting actions, action creators and reducers in three different files,
they are merged in a single file:

- [Ducks proposition](https://github.com/erikras/ducks-modular-redux)
- Actions follow [FSA convention](https://github.com/redux-utilities/flux-standard-action)

Consequently, we can have the following folder structure:

- `src/redux/products/article.js`: Article ducks
- `src/redux/products/catalog.js`: Catalog ducks

## Middleware

- logging: https://redux.js.org/advanced/middleware#the-final-approach
- API stuff: React-thunk or Saga
