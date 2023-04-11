-- vim.g.coq_settings = {auto_start = 'shut-up'} didn't work
vim.cmd([[COQnow -s]])
local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

require('neodev').setup()

--require("luasnip.loaders.from_vscode").lazy_load()

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'eslint' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({}))
end

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer'
})

local cmp = require('cmp')

cmp.setup({
    completion = {
        autocomplete = false
    }
    ----sources = {
    ----{ name = 'path' },
    ----{ name = 'nvim_lsp' },
    ----{ name = 'nvim_lua' },
    ----{ name = 'buffer',  keyword_length = 3 },
    ----{ name = 'luasnip', keyword_length = 3 },
    ----{ name = 'neoconf' }
    ----}
})

lsp.setup()
