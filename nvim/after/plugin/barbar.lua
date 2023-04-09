require('barbar').setup {
    animation = true,
    clickable = true,
    theme = 'tokyonight'
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<cmd>BufferNext<CR>', opts)
map('n', '≤', '<cmd>BufferPrevious<CR>', opts) -- Alt keys need to be bound to key Mac keyboard produces
map('n', '≥', '<cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<cmd>BufferMoveNext<CR>', opts)
map('n', '¯', '<cmd>BufferMovePrevious<CR>', opts)
map('n', '˘', '<cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<cmd>BufferLast<CR>', opts)
map('n', '¡', '<cmd>BufferGoto 1<CR>', opts)
map('n', '™', '<cmd>BufferGoto 2<CR>', opts)
map('n', '£', '<cmd>BufferGoto 3<CR>', opts)
map('n', '¢', '<cmd>BufferGoto 4<CR>', opts)
map('n', '∞', '<cmd>BufferGoto 5<CR>', opts)
map('n', '§', '<cmd>BufferGoto 6<CR>', opts)
map('n', '¶', '<cmd>BufferGoto 7<CR>', opts)
map('n', '•', '<cmd>BufferGoto 8<CR>', opts)
map('n', 'ª', '<cmd>BufferGoto 9<CR>', opts)
map('n', 'º', '<cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<cmd>BufferPin<CR>', opts)
map('n', 'π', '<cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<cmd>BufferClose<CR>', opts)
map('n', 'ç', '<cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
