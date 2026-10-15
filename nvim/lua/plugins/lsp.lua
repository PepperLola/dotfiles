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
						"basedpyright",
						"tailwindcss",
						"jdtls",
					},
				},
				dependencies = {
					{
						"mason-org/mason.nvim",
						opts = {
							ui = {
								package_installed = "✓",
								package_pending = "➜",
								package_uninstalled = "✗",
							},
							registries = {
								"github:Crashdummyy/mason-registry",
								"github:mason-org/mason-registry",
							},
						},
					},
					{
						"WhoIsSethDaniel/mason-tool-installer.nvim",
						opts = {
							ensure_installed = {
								"prettier",
								"stylua",
								"clangd",
							},
						},
					},
				},
			},
		},
		keys = {
			{ "gR", vim.lsp.buf.references, desc = "Show LSP references" },

			{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },

			{ "gd", vim.lsp.buf.definition, desc = "Show LSP definitions" },

			{ "gi", vim.lsp.buf.implementation, desc = "Show LSP implementations" },

			{ "gt", vim.lsp.buf.type_definition, desc = "Show LSP type definitions" },

			{
				"<leader>ca",
				function()
					vim.lsp.buf.code_action()
				end,
                mode = { "n", "v" },
				desc = "See available code actions",
			},

			{ "<leader>rn", vim.lsp.buf.rename, desc = "Smart rename" },

			{
				"<leader>D",
				function()
					vim.diagnostic.open_float({
						scope = "buffer",
					})
				end,
				desc = "Show buffer diagnostics",
			},

			{ "<leader>d", vim.diagnostic.open_float, desc = "Show line diagnostics" },

			{ "K", vim.lsp.buf.hover, desc = "Show documentation for what is under cursor" },

			{ "<leader>rs", ":LspRestart<CR>", desc = "Restart LSP" },

			{
				"<C-h>",
				vim.lsp.buf.signature_help,
                mode = "i",
				desc = "Signature Help",
			},

			{ "<leader>f", vim.lsp.buf.format, desc = "Format Buffer" },

			{
				"<leader>oi",
				function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source.organizeImports" },
							diagnostics = {},
						},
						apply = true,
					})
				end,
				desc = "Organize Imports",
			},

			{
				"<leader>fa",
				function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll" },
						},
						apply = true,
					})
				end,
				desc = "Fix All",
			},
		},
		config = function()
			for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
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
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰠠 ",
				[vim.diagnostic.severity.INFO] = " ",
			}

			vim.diagnostic.config({
				signs = {
					text = signs,
				},
				virtual_text = true,
				underline = true,
				update_in_insert = false,
			})

			vim.lsp.config("luals", {
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
							},
						},
					},
				},
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			vim.lsp.config("*", {
				capabilities = capabilities,
			})
		end,
	},
}
