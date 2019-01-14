---
title: React test coverage for Code Climate
articles: _kb/react/ci.md
tags: [ci, test, code climate, test coverage]
---

Split the workflow in _build+test_ jobs:

```yaml
# .circleci/config.yml
workflows:
  version: 2
  full-flow:
    jobs:
      - build
      - test:
          requires:
            - build
# Jobs
jobs:
  build:
  #  previous build definition
  test:
    docker:
      - image: circleci/node:11-browsers-legacy
    steps:
      - checkout
      - run:
          name: Testing
          command: npm test
```

If we leave it like this, `jest` is not found as dependencies as not fetch. Error is:

```
#!/bin/bash -eo pipefail
npm test


> learnzone-react@0.1.0 test /home/circleci/project
> jest

sh: 1: jest: not found
npm ERR! Test failed.  See above for more details.
Exited with code 1
```

Fix it by restoring the cached dependencies with `restore_cache`. This step
should not encountered problems as build just ran before.

## Setting coverage

[Jest handles that for us, _YEAH!_](https://jasonraimondi.com/posts/showing-code-coverage-for-a-react-app-using-code-climate-with-travis-ci).
Just update your package.json, jest part:

````json
    "collectCoverage": true,
    "coverageReporters": [
      "lcov"
    ],
    "collectCoverageFrom": [
      "src/**/*.{js,jsx,ts,tsx}"
    ]
    ```
````

And add Code Climate reporting to [CircleCI](https://docs.codeclimate.com/docs/circle-ci-test-coverage-example)
