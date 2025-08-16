-- LSP Configuration (proper after/plugin structure)
local lspconfig = require('lspconfig')
local keymap = vim.keymap

-- Define servers to set up
local servers = {
    -- html = {},
    -- cssls = {},
    tailwindcss = {
        filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    },
    -- prismals = {},
    -- graphql = {
    --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    -- },
    -- emmet_ls = {
    --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    -- },
    -- pyright = {},
    -- gopls = {},
    -- eslint = {},
    clangd = {},
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
local keymap_opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
    keymap_opts.buffer = bufnr

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
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, keymap_opts) -- show diagnostics for line

    keymap_opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, keymap_opts) -- jump to previous diagnostic in buffer

    keymap_opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, keymap_opts) -- jump to next diagnostic in buffer

    keymap_opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts) -- show documentation for what is under cursor

    keymap_opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", keymap_opts) -- mapping to restart lsp if necessary
end

-- Configure diagnostic signs using modern API
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        }
    }
})

for server, config in pairs(servers) do
    -- merge nvim-cmp capabilities with existing config capabilities
    config.capabilities = require("cmp_nvim_lsp").default_capabilities(config.capabilities or {})
    config.on_attach = on_attach
    require("lspconfig")[server].setup(config)
end
