---
title: "React testing: Jest and Enzyme"
articles: _kb/react/test.md
---

Testing React is most of the time synonym of Jest along with its loyal friend: Enzyme.

## Fixing all transpiling issues:

Startin from React 16, Jest is embedded with react scripts. However, running a simple
`.\node-modules\.bin\jest` leads to:

```
FAIL src/App.test.js
  ● Test suite failed to run

    Jest encountered an unexpected token

    This usually means that you are trying to import a file which Jest cannot parse, e.g. it's not plain JavaScript.

    By default, if Jest sees a Babel config, it will use that to transform your files, ignoring "node_modules".

    Here's what you can do:
     • To have some of your "node_modules" files transformed, you can specify a custom "transformIgnorePatterns" in your config.
     • If you need a custom transformation specify a "transform" option in your config.
     • If you simply want to mock your non-JS modules (e.g. binary assets) you can stub them out with the "moduleNameMapper" config option.

    You'll find more details and examples of these config options in the docs:
    https://jestjs.io/docs/en/configuration.html

    Details:

    SyntaxError: D:\github\_learn_zone\react\src\App.test.js: Unexpected token (7:18)

       5 | it('renders without crashing', () => {
       6 |   const div = document.createElement('div');
    >  7 |   ReactDOM.render(<App />, div);
         |                   ^
       8 |   ReactDOM.unmountComponentAtNode(div);
       9 | });
```

Adding a `.babelrc`:

```json
{
  "presets": ["env", "react"]
}
```

I'll let you check why `env` instead of `es20xx`. But such configuration requires some
babel plugins:

```
yarn add --dev babel-preset-env babel-preset-react
```

Only with both plugins, the error is

```
Plugin/Preset files are not allowed to export objects, only functions. In D:\github\_learn_zone\react\node_modules\babel-preset-react\lib\index.js

      at createDescriptor (node_modules/babel-jest/node_modules/@babel/core/lib/config/config-descriptors.js:178:11)
          at Array.map (<anonymous>)
```

Let's add the missing plugins:

```
yarn add --dev babel-core babel-jest babel-loader babel-polyfill
```

> TODO: check those libraries relevancy

And [provide some mocks for `.scss` files](https://jestjs.io/docs/en/webpack),
[otherwise jest will fail on SCSS files loading](https://github.com/facebook/jest/issues/3094).

If there is no SCSS mocks, error is

```
Test suite failed to run

    ({"Object.<anonymous>":function(module,exports,require,__dirname,__filename,global,jest){@import 'base/commons';
                                                                                             ^

    SyntaxError: Invalid or unexpected token

      1 | import React, { Component } from "react";
    > 2 | import "./stylesheets/application.scss";
        | ^
      3 | import Layout from "./layout/Layout";
      4 | import { Router } from "react-router-dom";
      5 | import auth from "./services/auth";

      at ScriptTransformer._transformAndBuildScript (node_modules/jest-runtime/build/script_transformer.js:403:17)
      at Object.<anonymous> (src/App.js:2:1)
```

If component is using es6 function, another error is raised:

```
 Jest encountered an unexpected token
      This usually means that you are trying to import a file which Jest cannot parse, e.g. it's not plain JavaScript.
      By default, if Jest sees a Babel config, it will use that to transform your files, ignoring "node_modules".
      Here's what you can do:
       • To have some of your "node_modules" files transformed, you can specify a custom "transformIgnorePatterns" in your config.
       • If you need a custom transformation specify a "transform" option in your config.
       • If you simply want to mock your non-JS modules (e.g. binary assets) you can stub them out with the "moduleNameMapper" config option.
      You'll find more details and examples of these config options in the docs:
      https://jestjs.io/docs/en/configuration.html
      Details:
        14 |    * via the `deleteMsg` props
        15 |    */
      > 16 |   deleteFunc = () => {
           |              ^
        17 |     let confirmMsg = this.props.deleteMsg || "Confirm deletion?";
        18 |     let confirmDel = window.confirm(confirmMsg);
        19 |     if (confirmDel) {
```

[Fix it by adding the appropriate plugin](https://stackoverflow.com/a/44360189/4906586):

```
yarn add --dev babel-plugin-transform-class-properties
```

And update `.babelrc`:

```json
{
  "plugins": ["transform-class-properties"]
}
```

## I forgot I had Redux

Let's fix Redux stuff... more detail on related article:

- Ensure that `index.js` only calls `<App />` so that `<App />` resolves a non-null store.
- Mock up API

But that's all for today.
