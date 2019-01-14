---
tech: css
title: Flexbox
tags: [css, flex, sticky]
mentioned:
  - /2018/12/12/flex-and-sticky
---

### Sticky panel

To have sticky panel such as in [Redux documentation](https://redux.js.org/introduction/getting-started#examples)
pages, leverage the [`position: sticky;`](https://www.sitepoint.com/css-position-sticky-introduction-polyfills/)

Considering the following HTML:

```html
<div class="container">
  <div class="sticky"></div>
  <main class="main"></main>
</div>
```

Let's have a simple sticky left panel with a standard main content:

```css
.container {
  display: flex;
  flex-direction: row; /* dezdez */
  min-height: 100vh;
  width: 100%;
}
.sticky-panel {
  /* to maintain at specific position */
  width: 250px;
  top: 0px;
  /* override stretch */
  align-self: flex-start;
  /* a sticky panel should not go out of viewport */
  max-height: 100vh;
  overflow-y: scroll;
  /* overpowered property */
  position: sticky;
}
.main {
  flex: 1; /* to take the remaining width */
}
```

Sources:
- [Sitepoint introduction to `position: sticky;`](https://www.sitepoint.com/css-position-sticky-introduction-polyfills/)
- [StackOverflow](https://stackoverflow.com/questions/44446671/my-position-sticky-element-isnt-sticky-when-using-flexbox)