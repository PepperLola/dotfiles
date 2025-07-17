return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            {
                "mason-org/mason-lspconfig.nvim",
                event = "VeryLazy",
                opts = {
                    automatic_enable = true,
                    ensure_installed = {
                        "lua_ls",
                        "biome",
                        "ts_ls",
                        "pyright",
                        "rust_analyzer",
                        "tailwindcss",
                    }
                },
                dependencies = {
                    {
                        "mason-org/mason.nvim",
                        opts = {
                            ui = {
                                package_installed = "✓",
                                package_pending = "➜",
                                package_uninstalled = "✗",
                            }
                        }
                    },
                    {
                        "WhoIsSethDaniel/mason-tool-installer.nvim",
                        opts = {
                            ensure_installed = {
                                "prettier",
                                "stylua",
                                "isort",
                                "pylint",
                                "clangd"
                            }
                        }
                    },
                },
            }
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Buffer local mappings
                    -- Check `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf, silent = true }

                    -- keymaps
                    opts.desc = "Show LSP references"
                    vim.keymap.set("n", "gR", vim.lsp.buf.references, opts) -- show definition, references

                    opts.desc = "Go to declaration"
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                    opts.desc = "Show LSP definitions"
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

                    opts.desc = "Show LSP implementations"
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- show lsp implementations

                    opts.desc = "Show LSP type definitions"
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- show lsp type definitions

                    opts.desc = "See available code actions"
                    vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions, in visual mode will apply to selection

                    opts.desc = "Smart rename"
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                    opts.desc = "Show buffer diagnostics"
                    vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts) -- show  diagnostics for file

                    opts.desc = "Show line diagnostics"
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                    opts.desc = "Show documentation for what is under cursor"
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                    opts.desc = "Restart LSP"
                    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

                    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
                end
            })

            for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and (err.code == -32802 or err.code == -32603) then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end

            local signs = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN]  = " ",
                [vim.diagnostic.severity.HINT]  = "󰠠 ",
                [vim.diagnostic.severity.INFO]  = " ",
            }

            vim.diagnostic.config({
                signs = {
                    text = signs,
                },
                virtual_text = true,
                underline = true,
                update_in_insert = false,
            })

            vim.lsp.config('luals', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            }
                        }
                    }
                }
            })
        end,
    },
}
