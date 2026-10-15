#!/usr/bin/env bash
# Copy this machine's current configs back into the repo, so you can review
# the diff and commit. The reverse of install.sh.
#
#   ./save.sh && git diff

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DOTFILES/paths.sh"

for entry in "${CONFIGS[@]}"; do
  repo="$DOTFILES/${entry%%:*}" live="${entry#*:}"

  if [ ! -e "$live" ]; then
    echo "skip     $live (not found)"
    continue
  fi

  if [ -L "$live" ]; then
    echo "skip     $live (symlink, run ./install.sh to replace it with a copy)"
    continue
  fi

  if [ -d "$live" ]; then
    # --delete so files removed on the machine are removed from the repo too.
    rsync -a --delete --exclude .DS_Store --exclude .nvimlog --exclude '*.bak*' "$live/" "$repo/"
  else
    cp "$live" "$repo"
  fi
  echo "saved    $live"
done

echo
git -C "$DOTFILES" status --short
