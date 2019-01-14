---
tech: react
title: React + CI
tags: [react, test, ci]
sources:
  - name: CircleCI with Code Climate
    link: https://docs.codeclimate.com/docs/circle-ci-test-coverage-example
mentioned:
  - /2018/12/13/react-test-coverage
---

## Setting up test & test coverage

How good my code is tested?

### Adding test to the workflow:

Update `.circleci/config.yml`:

```yaml
{% raw %}
# Using CircleCI 2
version: 2

# Workflow
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
  # ---------- Building job
  build:
  # ... unchanged ...
  # ---------- Testing job
  test:
    docker:
      # https://hub.docker.com/r/circleci/node/
      - image: circleci/node:11-browsers-legacy
    steps:
      - checkout
      # Cache should not have changed as "build" ran before. Just get it back
      - restore_cache:
          name: Restore Yarn Package Cache
          keys:
            - learnzone-react-dependencies-{{ checksum "yarn.lock" }}
      # Testing configuration must be configured in package.json
      - run:
          name: Testing
          command: npm test
{% endraw %}
```

### Adding test coverage

#### Building up coverage

With Jest, nothing to do, [Jest handles that for us, _YEAH!_](https://jasonraimondi.com/posts/showing-code-coverage-for-a-react-app-using-code-climate-with-travis-ci).
In package.json, update `jest` section:

```json
"jest":{
    "collectCoverage": true,
    "coverageReporters": [
      "lcov"
    ],
    "collectCoverageFrom": [
      "src/**/*.{js,jsx,ts,tsx}"
    ]
}
```

#### Connect to Code Climate

Get the `CC_TEST_COVERAGE_ID` from code climate settings and add it to CircleCI
environment variables.

```yaml
- run:
    name: Code Climate test-reporter setup
    command: |
      # download test reporter as a static binary
      curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
      chmod +x ./cc-test-reporter
      ./cc-test-reporter before-build
- run:
    name: your testing command here
    command: yarn test
# Code Climate sending report
- run:
    name: Code Climate report
    command: ./cc-test-reporter after-build --coverage-input-type lcov --exit-code $?
```

If you want to send test reporting only for master branch, change the report sending:

```yaml
- run:
    name: Code Climate report
    command: |
      if [ "${CIRCLE_BRANCH}" == "master" ]; then
        ./cc-test-reporter after-build --coverage-input-type lcov --exit-code $?
      fi
```

or duplicate jobs and leverage the CircleCI filter feature.

Sources:

- [Supported coverage input type](https://docs.codeclimate.com/docs/configuring-test-coverage#section-supported-languages-and-formats)
