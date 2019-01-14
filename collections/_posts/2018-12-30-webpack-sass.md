---
title: webpack sass
articles:
tags: [scss, webpack]
articles:
    - _kb/javascript/webpack.md
---

When testing [CSS framworks](https://al-un.github.io/css), I encountered the tilde
when import SCSS:

```scss
@import "~bulma";
```

This is specific to webpack and more specifically, to [sass-loader](https://github.com/webpack-contrib/sass-loader#imports)
