#!/bin/sh

# Credits: http://stackoverflow.com/a/750191

git filter-branch -f --env-filter "
    GIT_AUTHOR_NAME='zxwanderer'
    GIT_AUTHOR_EMAIL='new@email'
    GIT_COMMITTER_NAME='zxwanderer'
    GIT_COMMITTER_EMAIL='new@email'
  " HEAD
