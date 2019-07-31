---
tech: git
title: Git Stash
---

Reference: [git stashing documentation](https://git-scm.com/book/en/v1/Git-Tools-Stashing)

## Stash list

```sh
# Stash all changes
git stash
# Stash with custom message
git stash push -m "Some text"
# Stash specific file
git stash push -m "Only one file" some_folder/some_file.md

# Display stashes
git stash list
```

## Stash application

```sh
# Apply last stash
git stash apply
# Apply a specific stash: in this case, the third one
git stash apply stash@{3}
```

Or use

```
git stash pop
git stash pop stash@{3}
```

`git stash pop` remove the stash from the stack while `git stash apply` applies without modifying the stash stack

## Stash delete

```sh
# Drop the last stash
git stash drop
# Drop a specific stash
git stash drop stash@{3}
```
