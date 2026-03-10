return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "javascript",
                "go",
                "typescript",
                "python",
                "html",
                "css",
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
