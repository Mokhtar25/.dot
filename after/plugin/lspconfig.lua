return{
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  opts = {
    servers = {
    html = {},
    tailwindcss = {},
    graphql = {
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    },
    lua_ls = {
      settings = {
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
    },
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local keymap = vim.keymap -- for conciseness

    local keymap_opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      keymap_opts.buffer = bufnr

      keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev()
      end, keymap_opts)
      keymap.set("n", "]d", function()
        vim.diagnostic.goto_next()
      end, keymap_opts)

      -- set keybinds
      keymap_opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", keymap_opts) -- show definition, references

      keymap_opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts) -- go to declaration

      keymap_opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", keymap_opts) -- show lsp definitions

      keymap_opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", keymap_opts) -- show lsp implementations

      keymap_opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", keymap_opts) -- show lsp type definitions

      keymap_opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, keymap_opts) -- see available code actions, in visual mode will apply to selection

      keymap_opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts) -- smart rename

      keymap_opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", keymap_opts) -- show  diagnostics for file

      keymap_opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vm.diagnostic.open_float, keymap_opts) -- show diagnostics for line

      keymap_opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts) -- jump to previous diagnostic in buffer

      keymap_opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts) -- jump to next diagnostic in buffer

      keymap_opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts) -- show documentation for what is under cursor

      keymap_opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", keymap_opts) -- mapping to restart lsp if necessary
    end

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Setup each server with blink.cmp capabilities and on_attach
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      config.on_attach = on_attach
      lspconfig[server].setup(config)
  end
  end
}
