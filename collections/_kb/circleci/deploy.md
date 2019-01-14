---
tech: circleci
title: Workflow and deployment
tags: [circleci, workflow, deploy]
sources:
  - name: CircleCI configuration documentation
    link: https://circleci.com/docs/2.0/configuration-reference/#persist_to_workspace
  - name: CircleCI workflow documentation
    link: https://circleci.com/docs/2.0/workflows/
mentioned:
  - /2018/12/11/circleci-persist-artifacts
---

To deploy an application or a website, an additional step can be appended to do
the job. However, it is better to separate _build_ job from _deploy_ job.

## Workflow

_Build_ and _Deploy_ steps work the best when coupled within a workflow. A basic
workflow is:

```yaml
workflows:
  version: 2
  jobs:
    - build
    - deploy
```

### Filtering

Jobs can be filtered and conditionally be executed or ignored:

- Branch name
- Tags

Filtering can be:

- inclusive (`only:`)
- exclusive (`ignore:`)
- using Regex. E.g. to filter on `feature/*` branches only:
  ```yaml
  filters:
    branches:
      only: /^feature\/.*/
  ```

Filtering are forwarded to "children" jobs. For example:

```yaml
workflow:
  version: 2
  build-deploy:
    jobs:
      - build
      - test
      - approval:
          requires:
            - test
          type: approval
      - deploy-dev:
          requires:
            - test
          filters:
            only:
              - develop
      - deploy-prod:
          requires:
            - approval
```

- Commits on `develop` branch triggers: `build > test > deploy-dev`
- Commits on `master` branch triggers: `build > test > approval > deploy-prod`

### Scheduling

Example:

```yaml
workflow:
  version: 2

  nightly:
    triggers:
      - schedule:
          # Time is UTC: deploy every day at 00:00 UTC
          cron: "0 0 * * *"
          filters:
            branches:
              only:
                - develop
    jobs:
      - build
      - deploy
```

- [https://crontab.guru/](https://crontab.guru/)
- [Workflows to schedule jobs documentation](https://circleci.com/docs/2.0/workflows/)

### Manual approval

```yaml
workflows:
  version: 2

  build-deploy:
    jobs:
      - build
      # Approval job name is arbitrary
      - approval: # <<< A job that will require manual approval in the CircleCI web application.
          type: approval # <<< This key-value pair will set your workflow to a status of "On Hold"
          requires:
            - before_approval
      - deploy-prod:
          requires:
            - approval
```

- [Holding a workflow documentation](https://circleci.com/docs/2.0/workflows/#holding-a-workflow-for-a-manual-approval)
- [Job type documentation](https://circleci.com/docs/2.0/configuration-reference/#type)

## Persisting artifacts

Folder may be persisted from a job to another one to avoid recompiling. Use
`persist_to_workspace` to save and `attach_to_workspace` to load:

```yaml
jobs:
  build:
    working_directory: ~/repo
    steps:
      - persist_to_workspace:
          # Must be an absolute path, or relative path from working_directory.
          # This is a directory on the container which is  taken to be the root
          # directory of the workspace.
          root: ./
          # paths are relative to root and MUST be defined
          paths:
            - folder/path1/
            - folder/path2/
  deploy:
    # Warning! not the same as "build"
    working_directory: ~/
    steps:
    steps:
      - attach_workspace:
          # Must be absolute path or relative path from working_directory
          # => load `root` of persisted to workspace
          at: ~/repo
```

To make the workspace available through jobs, it has to be shared via a workflow
where the jobs dependencies defines who can access what:

```yaml
workflows:
  version: 2
  jobs:
    - build
    - deploy:
        - requires:
            # as "build" must run before "deploy", the workspace after "build"
            # is available for attaching
            - build
```

> Warning: `.circleci` folder cannot be copied!
