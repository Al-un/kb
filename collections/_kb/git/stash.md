---
tech: git
title: Git Stash
---

Reference: [git stashing documentation](https://git-scm.com/book/en/v1/Git-Tools-Stashing)

## Stash

```sh
# Stash all changes
git stash
# Stash with custom message
git stash push -m "Some text"
# Stash specific file
git stash pull -m "Only one file" some_folder/some_file.md

# Display stashes
git stash list
```

## Stash apply

```sh
# Apply last stash
git stash apply
# Apply a specific stash: in this case, the third one
git stash apply stash@{3}
```
