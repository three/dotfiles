#!/bin/sh
set -e
set -u
set -o pipefail

EXIT=0

for d in *; do
  if [ -d "$d" ]; then
    (
      cd "$d"
      echo -n "Inspecting $d... "
      git fetch -q
      LOCAL_COMMIT="$(git show-ref --hash refs/heads/master)"
      REMOTE_COMMIT="$(git show-ref --hash refs/remotes/origin/master)"
      if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
        echo "UPDATE REQUIRED!"
        EXIT=1
      else
        echo "up to date"
      fi
    )
  fi
done
exit $EXIT
