#!/usr/bin/env bash
# Link (or copy) the configs in this repo to where each tool expects them.
#
#   ./install.sh           symlink configs (edits on this machine land in the repo)
#   ./install.sh --copy    copy configs instead of symlinking
#   ./install.sh --brew    also install the tools + font from the Brewfile first
#
# Anything already at a target path is moved to ~/.dotfiles-backup/<timestamp>/
# before it's replaced, so nothing is lost.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
MODE="link"
BREW=0

for arg in "$@"; do
  case "$arg" in
    --copy) MODE="copy" ;;
    --brew) BREW=1 ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

# repo path -> target path
LINKS=(
  "tmux/tmux.conf:$HOME/.tmux.conf"
  "nvim:$HOME/.config/nvim"
  "alacritty:$HOME/.config/alacritty"
  "git/gitconfig:$HOME/.gitconfig"
  "zsh/zshrc:$HOME/.zshrc"
)

install_one() {
  local src="$DOTFILES/$1" dest="$2"

  # Already linked to this repo: nothing to do.
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok       $dest"
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
    echo "backup   $dest -> $BACKUP_DIR/"
  fi

  mkdir -p "$(dirname "$dest")"
  if [ "$MODE" = "link" ]; then
    ln -s "$src" "$dest"
    echo "link     $dest -> $src"
  else
    cp -R "$src" "$dest"
    echo "copy     $dest"
  fi
}

if [ "$BREW" = 1 ]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install it from https://brew.sh first." >&2
    exit 1
  fi
  brew bundle --file="$DOTFILES/Brewfile"
fi

for entry in "${LINKS[@]}"; do
  install_one "${entry%%:*}" "${entry#*:}"
done

# tmux plugin manager (resurrect + continuum are installed through it).
TPM="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM"
  "$TPM/bin/install_plugins" >/dev/null || true
  echo "tpm      installed tmux plugins"
fi

echo
echo "Done. Next:"
echo "  - Open nvim once: lazy.nvim installs plugins, Mason installs LSPs/formatters."
echo "  - In tmux, press prefix (Ctrl-Space) + I if any plugin is missing."
echo "  - Put machine-specific git settings (work email) in ~/.gitconfig.local"
echo "    and shell aliases/secrets in ~/.zshrc.local. Neither is tracked."
