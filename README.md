h3. How to squash your commits for a clean PR
Let's say you are on a branch named `uglyBranch` and have nothing ongoing.
The steps to follow are:
```
git fetch 
git branch -D master
# Just in case your merge goes wrong, save your branch in tmpbranch
git branch tmpbranch
git checkout -f master
git clean -dxf
git merge uglyBranch --no-ff --no-commit
# Fix your conflicts with `git mergetool`
git reset
# Verify the changeset with `git difftool`
git add -u .
git commit -m "An intuitive commit message"
git branch -D uglyBranch
git checkout -b uglyBranch
git push origin uglyBranch --force
# If everything went well, delete tmpbranch
git branch -D tmpbranch
```

Software
========
