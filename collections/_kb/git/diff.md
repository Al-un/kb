---
tech: git
title: Diff
---

## Difference

To analyse the difference between two branches, `git diff` is quite awesome ([`git diff` documentation](https://git-scm.com/docs/git-diff)).

### List all files modified: `--name-only`

```sh
# Between two branches
git diff --name-only {start branch} {end branch}

# Between two commits in the current branch
git diff --name-only HEAD~10 HEAD~5
```

Source: [StackOverflow](https://stackoverflow.com/a/1552353/4906586)

### List number of additions and deletions: `--compact-summary`

```sh
git diff {target branch} --compact-summary
```

Would output

```
al-un@al-un-xps:~/somewhere$ git diff develop --compact-summary
 /src/components/Component1.vue                             |   2 +-
 /src/components/Component2.spec.ts                         |   2 +-
 /src/components/Component2.vue                             |   2 +-
 /src/components/Component3.stories.ts                      |   4 ++--
 /src/components/Component4.vue (gone)                      | 138
 /src/components/Component5.vue                             |   2 +-
```
