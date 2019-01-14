---
tech: git
title: Git branches
---

## Branches management

### List branches

```sh
git branch
```

- `-a` argument includes remote branches

### Switch branches

To move to another branch

```sh
git checkout <new_branch>
```

To create a branch and move to created branch:

```sh
git checkout -b <new-branch>
```

### Rename branches

If you want to rename a branch while pointed to any branch, do:

```shell
git branch -m <oldname> <newname>
```

If you want to rename the current branch, you can do:

```shell
git branch -m <newname>
```

From [StackOverflow](https://stackoverflow.com/a/6591218/4906586)

### Removing branches

To remove a merged local branch:

```sh
git branch -d <branch_name>
```

In case branch was not merged locally, force deletion with `-D`

```sh
git branch -D <branch_name>
```

To delete a remote branch:

```sh
git push origin --delete <remote_branch_name>
```

From [this cheatsheet](https://makandracards.com/makandra/621-git-delete-a-branch-local-or-remote)
