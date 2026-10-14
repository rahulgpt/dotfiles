# Neovim Keybindings Quick Reference

**Leader Key:** `<Space>`

## Core Keybindings

### File Operations
- `<Leader>s` - Save file
- `<Leader>h` - Clear search highlights

### Navigation
- `j` - Move down (respects wrapped lines)
- `k` - Move up (respects wrapped lines)
- `H` - First non-blank character of line
- `L` - End of line
- `jk` - Escape (insert mode)

### Window Management
- `vv` - Vertical split
- `ss` - Horizontal split
- `<C-j>` - Window below
- `<C-k>` - Window above
- `<C-h>` - Window left
- `<C-l>` - Window right
- `<C-W>,` - Decrease split width
- `<C-W>.` - Increase split width
- `Q` - Close window

### Visual Mode
- `<Tab>` - Indent right
- `<S-Tab>` - Indent left
- `p` - Paste without yanking

## LSP Keybindings

- `K` - Show documentation (hover)
- `<Leader>rn` - Rename symbol
- `gf` - Code actions
- `<Leader>d` - Show diagnostics
- `gd` - Go to definition
- `gr` - Show LSP references

## File Explorer

- `<Leader>ee` - Toggle file explorer
- `<Leader>ef` - Toggle file explorer on current file
- `<Leader>ec` - Collapse file explorer
- `<Leader>er` - Refresh file explorer

## Fuzzy Finder

- `<C-P>` - Find files
- `<Leader>b` - Find buffers
- `<Leader>/` - Live grep (search in files)
- `gr` - Show LSP references

## Git

- `<Leader>o` - Git diff split view

## Terminal

- `<C-\>` - Toggle terminal (default mapping)
- `<Leader>tt` - Toggle terminal
- `<Leader>tf` - Toggle floating terminal
- `<Leader>th` - Toggle horizontal terminal
- `<Leader>tv` - Toggle vertical terminal
- `jk` or `<Esc>` - Exit terminal mode (in terminal)
- `<C-h/j/k/l>` - Navigate windows (in terminal)

## Autocompletion (Insert Mode)

- `<C-k>` - Previous suggestion
- `<C-j>` - Next suggestion
- `<C-b>` - Scroll docs up
- `<C-f>` - Scroll docs down
- `<C-Space>` - Show completion
- `<C-e>` - Close completion
- `<CR>` - Confirm selection
- `<Tab>` - Select next / Expand snippet / Trigger completion
- `<S-Tab>` - Select previous / Jump back in snippet

