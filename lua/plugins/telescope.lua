return {
    {
        'nvim-telescope/telescope.nvim',
        -- Track master: 0.1.x is unmaintained and calls
        -- nvim-treesitter.parsers.ft_to_lang which the `main` branch removed.
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        theme = "ivy"
                    }
                },
                extensions = {
                    fzf = {
                    }
                }
            }

            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
            -- vim.keymap.set('n', '<leader>fs', function()
            --     builtin.grep_string({ search = vim.fn.input("Grep > ") })
            -- end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

            vim.keymap.set("n", "<space>fh", builtin.help_tags)

            require "config.telescopeMultigrep".setup()
        end
    }
}
--
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fs', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
-- vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
--
