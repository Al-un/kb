---
tech: react
title: Saga
tags: [react, redux, saga]
sources:
  - name: Saga documentation
    link: https://redux-saga.js.org/
---

To handle asynchronous request for Redux

## Folder structure

Combined with React ducks, folder structure becomes:
- `src/redux/products/article.js`: Articles ducks
- `src/redux/products/article.sagas.js`: Articles sagas
- `src/redux/products/catalog.js`: Catalogs ducks
- `src/redux/products/catalog.sagas.js`: Catalogs sagas