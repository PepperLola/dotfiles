-- Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Timeout (for mini.surround vs substitute)
vim.opt.timeoutlen = 200

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.api.nvim_set_option_value("colorcolumn", "", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.rkt" },
    callback = function()
        vim.opt.colorcolumn = "80"
    end
})

vim.opt.conceallevel = 2

-- Shell
vim.opt.sh = '/bin/zsh'

-- Undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "
-- vim.g.maplocalleader = ";"

-- Split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Treesitter folding 
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false

vim.g.knap_settings = {
    htmltohtmlviewerlaunch = "live-server --quiet --open=%outputfile% --watch=%outputfile% --wait=800",
    htmltohtmlviewerrefresh = "none",
    mdtohtmlviewerlaunch = "live-server --quiet --open=%outputfile% --watch=%outputfile% --wait=800",
    mdtohtmlviewerrefresh = "none",
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
