---
tech: markdown
title: Images
---

## Add a CSS class

Natively, markdown does not provide support for CSS class. Hacks exist.

```markdown
![image alt text](/path/to/my/image#my-css-class "image title")
```

Then in your stylesheets:

```scss
img[src*="#my-css-class]{
    width: 250px;
    display: block;
    align: auto;
}
```

Hacks from [here](https://www.xaprb.com/blog/how-to-style-images-with-markdown/)
