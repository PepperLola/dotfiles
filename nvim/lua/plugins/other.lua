return {
	{
		"seandewar/nvimesweeper",
		cmd = "Nvimesweeper",
		lazy = true,
	},
	{
		"jim-fx/sudoku.nvim",
		cmd = "Sudoku",
		opts = {},
	},
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		lazy = true,
	},
	{ "wakatime/vim-wakatime", lazy = false },
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		opts = {
			font = "FiraCode NF=34",
		},
	},
	{
		"gruvw/strudel.nvim",
		build = "npm install",
		cmd = "StrudelLaunch",
		ft = "str",
		config = true,
	},
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		opts = {
			picker = "fzf-lua",
			enable_builtin = true,
		},
		keys = {
			{
				"<leader>oi",
				"<CMD>Octo issue list<CR>",
				desc = "List GitHub Issues",
			},
			{
				"<leader>op",
				"<CMD>Octo pr list<CR>",
				desc = "List GitHub PRs",
			},
			{
				"<leader>od",
				"<CMD>Octo discussion list<CR>",
				desc = "List GitHub Discussions",
			},
			{
				"<leader>on",
				"<CMD>Octo notification list<CR>",
				desc = "List GitHub Notifications",
			},
			{
				"<leader>os",
				function()
					require("octo.utils").create_base_search_command({ include_current_repo = true })
				end,
				desc = "Search GitHub",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
