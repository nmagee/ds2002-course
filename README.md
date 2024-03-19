# ds2002

Welcome to DS2002 Data Science Systems!

This repository tracks your working environment during this course. Some course material
and tools will be distributed in this way so that we all have a common set of tools, scripts, and datasets.

This requires that you clone and stay current with the **course code respository** and have the appropriate
tools to complete exercises. 

## Updating your fork 

To stay current with new releases into the course repository, follow these steps:

1. Add an upstream source
```
git remote add upstream git@github.com:nmagee/ds2002-course.git
```
2. Fetch from the upstream branch:
```
git fetch upstream
```
3. Merge your branch with the upstream branch.
```
git merge upstream/main main
```

This can be run in a single block:
```
git remote add upstream git@github.com:nmagee/ds2002-course.git
git fetch upstream
git merge upstream/main main
```

## Saving your changes

If you generate code, scripts, data files, etc. that you would like to keep, simply add, commit, and push
the files back to **your** fork of the repository:
```
git add .
git commit -m "Some meaningful message"
git push origin main
```

Remember that changes you commit and push will be saved to YOUR fork of the repository.
