---
title: Persist artifacts in CircleCI
articles: _kb/circleci/deploy.md
---

This website could have used `master branch/docs` folder as a website:

- I build locally my Jekyll website
- If the output folder is not already set to `/docs/`, copy content from `/_site`
  to `/docs/`
- commit and push master branch

But for the sake of learning, let's do split the Circle CI workflow in two jobs:

- build
- deploy

I need to keep the artifacts produced by the _build_ job to have it deployed by
the _deploy_ job. To do so, CircleCI offers `persist_to_workspace` and `attach_workspace`.
