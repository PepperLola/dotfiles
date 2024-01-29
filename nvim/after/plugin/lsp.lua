-- vim.g.coq_settings = {auto_start = 'shut-up'} didn't work
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.extend_cmp()

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'eslint', 'jdtls', 'kotlin_language_server' }

cmp.setup({
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    })
})
lsp.extend_lspconfig()

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = servers,
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

-- local lspconfig = require('lspconfig')
--
-- require('neodev').setup()
--
-- --require("luasnip.loaders.from_vscode").lazy_load()
--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = { "documentation", "detail", "additionalTextEdits" }
-- }
-- capabilities.offsetEncoding = 'utf-16'
--
-- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
-- lspconfig.racket_langserver.setup {}
-- lspconfig.clangd.setup {
--     capabilities = capabilities,
--     cmd = {
--         "/opt/homebrew/opt/llvm/bin/clangd",
--         "--background-index",
--         "--pch-storage=memory",
--         "--all-scopes-completion",
--         "--pretty",
--         "--header-insertion=never",
--         "-j=4",
--         "--inlay-hints",
--         "--header-insertion-decorators",
--         "--function-arg-placeholders",
--         "--completion-style=detailed",
--         "-I **"
--     },
--     filetypes = { "c", "cpp", "objc", "objcpp" },
--     root_dir = function(fname)
--         return lspconfig.util.root_pattern("project.yml")(fname) or
--             lspconfig.util.root_pattern("src")(fname)
--     end,
--     init_options = {
--         fallbackFlags = {
--             "%c -std=c17",
--             "%cpp -std=c++2a"
--         }
--     },
-- }
--
-- local function optimize_imports()
--     local params = {
--         command = "_typescript.organizeImports",
--         arguments = { vim.api.nvim_buf_get_name(0) },
--         title = ""
--     }
--     vim.lsp.buf.execute_command(params)
-- end
--
-- lspconfig.tsserver.setup {
--     capabilities = capabilities,
--     commands = {
--         OptimizeImports = {
--             optimize_imports,
--             description = "Optimize Imports"
--         }
--     }
-- }
--
--
-- -- Auto Import
--
-- local cmp = require('cmp')
-- local cmp_select = { behaviour = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     ['<C-Space'] = cmp.mapping.complete(),
-- })
--
-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I',
--     }
-- })
--
-- vim.keymap.set("n", "<A-o>", optimize_imports)
-- vim.keymap.set("n", "ø", optimize_imports)
--
-- lsp.on_attach(function(client, bufnr)
--     lsp.default_keymaps({ buffer = bufnr })
--     lsp.buffer_autoformat()
-- end)
--
-- lsp.setup()
