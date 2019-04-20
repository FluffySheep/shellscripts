# This script unstages the most recent commit from your history.
# You can run `git log` to see what the most recent commit is.

git reset --soft HEAD^
git reset
git status
