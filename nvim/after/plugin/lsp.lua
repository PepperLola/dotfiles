-- vim.g.coq_settings = {auto_start = 'shut-up'} didn't work
local lsp = require('lsp-zero')
lsp.preset('recommended')

require('neodev').setup()

--require("luasnip.loaders.from_vscode").lazy_load()

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'eslint', 'jdtls', 'kotlin_language_server' }


require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed(servers)

local cmp = require('cmp')
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
    }
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

lsp.setup()
