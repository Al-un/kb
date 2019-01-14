---
tech: react
title: Props
tags: [react, props, component]
sources:
  - name: React documentation on PropTypes
    link: https://reactjs.org/docs/typechecking-with-proptypes.html#proptypes
---

# React props enhancement

## Prop types

Import:
```javascript
import PropTypes from 'prop-types';
```
and check:
```javascript
Greeting.propTypes = {
  name: PropTypes.string
};
```

Define default props values:
```javascript
Greeting.defaultProps = {
  name: 'Stranger'
};
```