return {
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        dependencies = {
            "rafamadriz/friendly-snippets"
        },
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        keys = {
            {
                "<C-L>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = { "i", "s" },
                desc = "Jump forward",
            },
            {
                "<C-J>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
                desc = "Jump backward",
            },
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/luasnip" } })
        end,
    },
}
