return {
    'HiPhish/rainbow-delimiters.nvim',
    {
        'ThePrimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
		vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { desc = '[g]it [s]tatus' })
		vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = '[g]it [c]ommit' })
		vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { desc = '[g]it [p]ull' })
		vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { desc = '[g]it [P]ush' })
		vim.keymap.set("n", "<leader>gb", require('telescope.builtin').git_branches, { desc = '[g]it [b]ranches' })
	end,
    },
    'tpope/vim-rhubarb',
    'subnut/nvim-ghost.nvim',
    'mfussenegger/nvim-dap',
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' }
    },
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go'
}
