#!/bin/sh
set -e
set -u
set -o pipefail

# I usually have a directory with all my aur repos and use this
# script to keep them updated.

for d in *; do
  if [ -d "$d" ]; then
    (
      cd "$d"
      echo "Inspecting $d..."
      git fetch
      LOCAL_COMMIT="$(git show-ref --hash refs/heads/master)"
      REMOTE_COMMIT="$(git show-ref --hash refs/remotes/origin/master)"
      if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
        echo "Updating $d..."
        git pull
        makepkg -si
      else
        echo "Nothing to Update"
      fi
    )
  fi
done
