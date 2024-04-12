return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
    },
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        },
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/luasnip" } })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = "neorg" },
                }, {
                    { name = 'buffer' },
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        lazy = true,
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            local servers = { 'clangd', 'rust_analyzer', 'pyright', 'eslint', 'jdtls', 'kotlin_language_server', 'typst_lsp' }

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)
            
            require('mason-lspconfig').setup({
                ensure_installed = servers,
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        local lspconfig = require('lspconfig')
                        lspconfig.lua_ls.setup(lua_opts)
                        lspconfig.clangd.setup {
                            cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--background-index" },
                            root_dir = lspconfig.util.root_pattern("compile_commands.json", ".clangd"),
                        }
                    end,
                }
            })
        end,
    },
}
