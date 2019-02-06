---
tech: git
title: Git tags
---

Reference: [git tagging documentation](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

## List tags

```sh
# List all tags
git tag
# Regex T_T
git tag -l "v1.8.5*"
# Show a specific tag
git show v1.4.5
```

## Annotated vs Lightweight tags

```sh
# Annotated
git tag -a v1.4 -m "release 1.4"
# Lightweight
git tag v1.4-lw
```

## Tag & remote

```sh
# Push tags
git push origin v1.4
```
