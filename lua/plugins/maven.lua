return {
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_word = "<CR-y>",
                }
            })
        end,
    },
    "L3MON4D3/LuaSnip",
    keys = {
        { "<tab>",   false, mode = { "i", "s" } },
        { "<s-tab>", false, mode = { "i", "s" } },
    },
    {
        "hrsh7th/nvim-cmp",
        keys = {
            { "<tab>",   false, mode = { "i", "s" } },
            { "<s-tab>", false, mode = { "i", "s" } },
        },
    }

}
