local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-h>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-g>', function()
	builtin.live_grep();
end)

require("telescope").setup()
