# dotfiles

My tmux, Neovim, Alacritty, git and zsh setup (macOS).

| Config     | Lives at               |
| ---------- | ---------------------- |
| `tmux/`    | `~/.tmux.conf`         |
| `nvim/`    | `~/.config/nvim`       |
| `alacritty/` | `~/.config/alacritty` |
| `git/`     | `~/.gitconfig`         |
| `zsh/`     | `~/.zshrc`             |

## Setup on a new machine

```sh
git clone https://github.com/rahulgpt/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --brew
```

- `--brew` installs neovim, tmux, ripgrep, fzf, Alacritty, FiraCode Nerd Font, etc. from the `Brewfile`. Skip it if you already have them.
- By default configs are **symlinked**, so editing them on any machine changes the repo. Commit and pull to sync. Use `--copy` for plain copies instead.
- Existing configs are moved to `~/.dotfiles-backup/<timestamp>/` first.

Then open `nvim` once to let lazy.nvim and Mason install everything. Neovim keybindings are in [`nvim/README.md`](nvim/README.md).

## Machine-specific config

These files are sourced/included if present and never committed:

- `~/.gitconfig.local`: e.g. a work email
  ```ini
  [user]
  	email = you@company.com
  ```
- `~/.zshrc.local`: aliases, SSH hosts, tokens, tool init that only applies to one machine.

The zshrc expects [oh-my-zsh](https://ohmyz.sh) (`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`) but still loads without it.

## Notes

- tmux prefix is `Ctrl-Space`. Copy mode uses `pbcopy`, so it's macOS-only as written.
- `alacritty/themes/` is the [alacritty-theme](https://github.com/alacritty/alacritty-theme) collection; switch themes via the `import` line in `alacritty.toml`.
