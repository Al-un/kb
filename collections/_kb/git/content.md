---
tech: git
title: Content versioning
---

## Commit

```shell
# list staged changes and un-staged changes
git status
# add all files
git add .
# or add specific file
git add /path/to/my/file.extension
# commit
git commit -m "commit message"
```

### Empty commit

Sometimes, you just need [a commit without changes](https://coderwall.com/p/vkdekq/git-commit-allow-empty)

```sh
git commit --allow-empty -m "commit message"
```

### Amend commit

Something is missing in the last commit? Just [_amend_ it](https://www.atlassian.com/git/tutorials/rewriting-history#git-commit--amend). **Do not rewrite public branches**.

```sh
# "--no-edit" keeps the initial commit message. Otherwise a
# "-m 'commit message'# is required
git commit --amend --no-edit
```

## Delete

```shell
# remove local and remote
git rm filename.ext
# remove remote only after commit
git rm --cached filename.ext
# remote remote folder
git rm --cached -r foldername
```
