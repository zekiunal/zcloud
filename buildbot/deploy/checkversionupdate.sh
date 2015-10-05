#!/bin/bash
# get files commited
# git diff-tree --no-commit-id --name-only -r (git rev-parse HEAD)

# checkout to latest tag
# git checkout (git describe --abbrev=0 --tags)


FILES=$(git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD))

# check if version file in latest commit
if echo $FILES | grep -q "VERSION"; then
    git checkout $(git describe --abbrev=0 --tags);
    echo 1;
else
	echo 0;
fi