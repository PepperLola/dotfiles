-- vim.g.coq_settings = {auto_start = 'shut-up'} didn't work
local lsp = require('lsp-zero')
lsp.preset('recommended')

local lspconfig = require('lspconfig')

require('neodev').setup()

--require("luasnip.loaders.from_vscode").lazy_load()

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'eslint', 'jdtls', 'kotlin_language_server' }


lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed(servers)

-- Auto Import
local function optimize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

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

lspconfig.tsserver.setup {
    on_attach == on_attach,
    capabilities = capabilities,
    commands = {
        OptimizeImports = {
            optimize_imports,
            description = "Optimize Imports"
        }
    }
}

vim.keymap.set("n", "<A-o>", optimize_imports)
vim.keymap.set("n", "ø", optimize_imports)

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

lsp.setup()
