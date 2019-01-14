---
tech: css
title: Fonts
tags: [css, fonts]
---

## Font family

```css
font-family: 'NotoSans', sans-serif;
```

Sources:
- https://www.w3schools.com/Css/css_font.asp

## Font-face

To import custom fonts:
```css
@font-face {
    font-family: 'NotoSans';
    src: url('../fonts/NotoSans-Regular.ttf');
}
```
Path is relative to CSS file path. Font is used as described before

Sources: 
- https://css-tricks.com/snippets/css/using-font-face/