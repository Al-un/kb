---
tech: css
title: Bootstrap
tags: [css, bootstrap, flex, layout]
mentioned:
---

## Grid layout

Use `class='container'` or `class='container-fluid'` to define a grid layout. Each
layout has multiple row where are defined columns:

```html
<div class="container">
  <fieldset class="form-group">
    <legend>Attributes</legend>

    <div class="row">
      <div class="col col-md-4"><!-- content --></div>
      <div class="col col-md-8"><!-- content --></div>
    </div>
  </fieldset>
</div>
```

## Forms components

### File inputs

From [Bootstrap docs](https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input)
