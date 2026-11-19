# repo path -> location on the machine. Used by install.sh and save.sh.
CONFIGS=(
  "tmux/tmux.conf:$HOME/.tmux.conf"
  "nvim:$HOME/.config/nvim"
  "alacritty:$HOME/.config/alacritty"
  "git/gitconfig:$HOME/.gitconfig"
  "zsh/zshrc:$HOME/.zshrc"
  # Zed: only these, not the whole dir (it also holds Zed's prompt-library database)
  "zed/settings.json:$HOME/.config/zed/settings.json"
  "zed/keymap.json:$HOME/.config/zed/keymap.json"
  "zed/themes:$HOME/.config/zed/themes"
)
