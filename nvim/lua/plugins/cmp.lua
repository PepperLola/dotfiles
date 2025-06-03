return {
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
        version = '*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },
}
