return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({})

    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls",           -- TypeScript/JavaScript
        "html",            -- HTML
        "cssls",           -- CSS
        "lua_ls",          -- Lua
        "angularls",       -- Angular
        "rust_analyzer",   -- Rust
        "pylsp",           -- Python
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
        "prettierd",
      },
    })
  end,
}
