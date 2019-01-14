---
tech: css
title: Variable in SASS
mentioned:
  - /2018/12/12/flex-and-sticky
---

## Use variable in formula:

Interpolation FTW:
```scss
$topHeight: 50px;
.plop{
    height: calc(100vh - #{$topHeight});
}
```

Source:
- [CodePen example](https://codepen.io/thebabydino/pen/hgFno)