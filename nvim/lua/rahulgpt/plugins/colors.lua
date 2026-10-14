return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- "hard" | "soft" | ""; "hard" = darker bg (#1d2021), more pop
      bold = true,
      undercurl = true,
      underline = true,
      italic = {
        strings = false,
        comments = false, -- terminal italics often render muddy; keep comments upright
        operators = false,
        folds = true,
      },
      -- Brighten the dimmest tokens so they stop blending into the background.
      palette_overrides = {
        gray = "#a89984", -- comments (was #928374), readable but still recedes
      },
      overrides = {
        -- Make the line-number column quieter so code stands out more.
        LineNr = { fg = "#665c54" },
        Comment = { italic = false },
      },
    })

    vim.o.background = "dark"

    vim.cmd([[
      colorscheme gruvbox
      hi CocUnusedHighlight cterm=underline gui=underline guifg=#6B6860
    ]])

    -- LSP semantic token highlight groups (gopls provides these for Go)
    vim.api.nvim_set_hl(0, "@lsp.type.function", { link = "Function" })
    vim.api.nvim_set_hl(0, "@lsp.type.method", { link = "Function" })
    vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = "#d3869b" })
    vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "Type" })
    vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "Include" })
    vim.api.nvim_set_hl(0, "@lsp.type.keyword", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@lsp.type.string", { link = "String" })
    vim.api.nvim_set_hl(0, "@lsp.type.number", { link = "Number" })
    vim.api.nvim_set_hl(0, "@lsp.type.operator", { link = "Operator" })
    vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "Comment" })
  end,
}
