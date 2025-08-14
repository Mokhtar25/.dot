local mason = require("mason")

-- import mason-lspconfig
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

-- "ts_ls",
mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = {
        -- "jdtls",
        -- "html",
        -- "cssls",
        -- "tailwindcss",
        -- "lua_ls",
        -- "emmet_ls",
        -- "gopls",
        -- "pyright",
        "clangd",
        -- Note: typescript-language-server is NOT included here
        -- because we use typescript-tools.nvim instead
    },
    -- auto-install configured servers (with lspconfig)
    automatic_installation = true, -- not the same as ensure_installed
})
