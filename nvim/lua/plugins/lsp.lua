return {
    {
        'williamboman/mason.nvim',
        dependencies = { 'williamboman/mason-lspconfig.nvim' },
        lazy = false,
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and err.code == -32802 then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end

            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ts_ls",
                    "eslint",
                    "tailwindcss",
                    "emmet_language_server",
                    "jsonls",
                    "rust_analyzer",
                    "svelte",
                    "tinymist",
                    "clangd",
                    "jdtls",
                    "kotlin_language_server",
                    "gopls",
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        dependencies = {
            "leiserfg/blink_luasnip",
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
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = { 'L3MON4D3/LuaSnip', 'leiserfg/blink_luasnip', 'rafamadriz/friendly-snippets' },
        version = 'v0.*',
        opts = {
            -- for some reason uninstalls luasnip and other related plugins??
            -- accept = {
            --     expand_snippet = require("luasnip").lsp_expand,
            -- },
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                completion = {
                    enabled_providers = { 'lsp', 'path', 'luasnip', 'snippets', 'buffer' },
                },
                providers = {
                    luasnip = {
                        name = "luasnip",
                        module = "blink_luasnip",
                        score_offset = -3,
                        opts = {
                            use_show_condition = false,
                            show_autosnippets = true,
                        }
                    }
                },
            },
        },
        opts_extend = { "sources.completion.enabled_providers" }
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'saghen/blink.cmp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                -- make language server aware of runtime files
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },
                emmet_language_server = {
                    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
                },
                clangd = {
                    cmd = { "clangd" },
                    filetypes = { "c", "cpp", "cc" },
                    -- root_dir = require('lspconfig').util.root_pattern("compile_commands.json", ".git")
                },
            }
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            local keymap = vim.keymap

            local lsp_opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
                lsp_opts.buffer = bufnr

                lsp_opts.desc = "Show LSP references"
                keymap.set("n", "gR", vim.lsp.buf.references, lsp_opts) -- show definition, references

                lsp_opts.desc = "Go to declaration"
                keymap.set("n", "gd", vim.lsp.buf.declaration, lsp_opts) -- go to declaration

                lsp_opts.desc = "Show LSP definitions"
                keymap.set("n", "gD", vim.lsp.buf.definition, lsp_opts) -- show lsp definitions

                lsp_opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", vim.lsp.buf.implementation, lsp_opts) -- show lsp implementations

                lsp_opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", vim.lsp.buf.type_definition, lsp_opts) -- show lsp type definitions

                lsp_opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts) -- see available code actions, in visual mode will apply to selection

                lsp_opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts) -- smart rename

                lsp_opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, lsp_opts) -- show diagnostics for line

                lsp_opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, lsp_opts) -- jump to previous diagnostic in buffer

                lsp_opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, lsp_opts) -- jump to next diagnostic in buffer

                lsp_opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts) -- show documentation for what is under cursor

                lsp_opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", lsp_opts) -- mapping to restart lsp if necessary

                lsp_opts.desc = "Format Buffer"
                keymap.set("n", "<leader>f", vim.lsp.buf.format, lsp_opts)
            end

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
            })

            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end,
    },
}
