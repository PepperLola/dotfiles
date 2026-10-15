return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
						},
					},
				},
			}
		end,
		keys = {
			{ "<leader>ca", "<cmd>RustLsp codeAction<cr>", desc = "Rust Code Actions", ft = "rust" },
			{ "K", "<cmd>RustLsp hover actions<cr>", desc = "Rust Hover Actions", ft = "rust" },
			{ "<leader>ce", "<cmd>RustLsp explainError<cr>", desc = "Rust Explain Error", ft = "rust" },
		},
	},
}
