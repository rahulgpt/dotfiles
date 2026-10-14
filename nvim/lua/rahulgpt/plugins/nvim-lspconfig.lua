return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  enabled = true,
  config = function()
    local util = require("lspconfig.util")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Disable inline error messages and configure diagnostic signs
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        border = "single",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✖",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "󰠠",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
    })

    -- Add border to floating window
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silent = true })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silent = true })

    -- Make float window transparent start

    local set_hl_for_floating_window = function()
      vim.api.nvim_set_hl(0, "NormalFloat", {
        link = "Normal",
      })
      vim.api.nvim_set_hl(0, "FloatBorder", {
        bg = "none",
      })
    end

    set_hl_for_floating_window()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      desc = "Avoid overwritten by loading color schemes later",
      callback = set_hl_for_floating_window,
    })

    -- Make float window transparent end

    local on_attach = function(client, bufnr)
      -- format on save using gopls for Go files
      if client.name == "gopls" and client.supports_method("textDocument/formatting") then
        local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormatting_" .. bufnr, { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = lsp_fmt_group,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end

      vim.keymap.set(
        "n",
        "K",
        vim.lsp.buf.hover,
        { buffer = bufnr, desc = "Show documentation for what is under cursor" }
      )
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
      vim.keymap.set(
        { "n", "v" },
        "gf",
        vim.lsp.buf.code_action,
        { buffer = bufnr, desc = "See available code actions" }
      )
      vim.keymap.set(
        "n",
        "<leader>d",
        vim.diagnostic.open_float,
        { buffer = bufnr, desc = "Show diagnostics for line" }
      )
      -- vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", {buffer = bufnr, desc = 'Show definition, references'})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- configure typescript server with plugin (using new API)
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("ts_ls")

    -- configure html server
    vim.lsp.config("html", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("html")

    -- configure angular server
    vim.lsp.config("angularls", {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = util.root_pattern("angular.json", "project.json", "nx.json"),
    })
    vim.lsp.enable("angularls")

    -- configure lua server (with special settings)
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    -- configure css server
    vim.lsp.config("cssls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("cssls")

    -- configure go server
    vim.lsp.config("gopls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("gopls")

    -- configure python server
    vim.lsp.config("pylsp", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable("pylsp")

    -- configure rust server
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- format on save
        if client.supports_method("textDocument/formatting") then
          local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormatting_" .. bufnr, { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_fmt_group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    })
    vim.lsp.enable("rust_analyzer")
  end,
}
