return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                astro = { "prettier" },
                javascript = { "biome", "prettier", stop_after_first = true },
                typescript = { "biome", "prettier", stop_after_first = true },
                javascriptreact = { "biome", "prettier", stop_after_first = true },
                typescriptreact = { "biome", "prettier", stop_after_first = true },
                css = { "prettier" },
                html = { "prettier" },
                json = { "biome", "prettier", stop_after_first = true },
                yaml = { "yq", "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                go = { "gofumpt", "golines", "goimports" },
                sql = { "sqruff" },
            },
            formatters = {
                biome = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/biome",
                },
            },
        })

        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line[1]:len() },
                }
            end
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
                range = range,
            })
        end, { range = true })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
