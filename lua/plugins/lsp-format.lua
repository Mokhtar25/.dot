return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                astro = { "prettier" },
                javascript = { "biome", "prettier" },
                typescript = { "biome", "prettier" },
                javascriptreact = { "biome", "prettier" },
                typescriptreact = { "biome", "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "biome", "prettier" },
                yaml = { "yq", "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                go = { "gofumpt", "golines", "goimports" },

                sql = { "sqruff" },
            }
        })
        vim.api.nvim_create_user_command("Format", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, {})

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
