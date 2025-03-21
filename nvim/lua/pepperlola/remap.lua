vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move between windows with C-dir
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize windows with C-arrow
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move blocks of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Typst keybinds to make visual selection bold/italic/underlined
vim.keymap.set("v", "<C-b>", "Os#text(weight: \"bold\")[<esc>pa]<esc>")
vim.keymap.set("v", "<C-i>", "Os#emph[<esc>pa]<esc>")
vim.keymap.set("v", "<C-u>", "Os#underline[<esc>pa]<esc>")

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")
-- Keep cursor in center when jumping half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep search results in center of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without copying highlighted text
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Paste from system clipboard
vim.keymap.set("n", "<leader>P", "\"*p")
vim.keymap.set("v", "<leader>P", "\"*p")

-- Delete to void register (no copy)
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Save vertical changes on escape
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Queue substitution for current word
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- clang-format
-- vim.keymap.set("n", "<C-K>", ":pyf /opt/homebrew/opt/llvm/share/clang/clang-format.py")

-- Racket
-- SPD Handin
vim.keymap.set("n", "<leader>sh", function()
    vim.fn.jobstart(
        "racket -e '(require (file \"" ..
        vim.fn.expand("~/Library/Racket/8.10/collects/spd-handin/client-gui.rkt") ..
        "\")) (new handin-frame\\% [filename \"" ..
        vim.fn.expand("%:p") .. "\"])'", {
            on_stderr = (function(chan, data, name)
                vim.notify(vim.inspect(data), vim.log.levels.ERROR)
            end)
        })
end)

-- Run file
vim.keymap.set("n", "<leader>rk", "<cmd>:te racket %:p<CR>")

-- Test file
vim.keymap.set("n", "<leader>rt", function()
    local f = io.popen("raco test " .. vim.fn.expand("%:p"))
    local text = f:read("*a")
    if string.match(text, "pass") then
        vim.notify(text)
    else
        vim.api.nvim_command("botright vsplit RACKET_TEST")
        local buffer_number = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buffer_number, "readonly", false)
        vim.api.nvim_buf_set_lines(buffer_number, -1, -1, true, f:lines())
        vim.api.nvim_buf_set_option(buffer_number, "readonly", true)
        vim.api.nvim_buf_set_option(buffer_number, "modified", false)

        local buffer_window = vim.api.nvim_call_function("bufwinid", { buffer_number })
        local buffer_line_count = vim.api.nvim_buf_line_count(buffer_number)
        vim.api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
    end
    f:close()
end)

-- Run repl including file
vim.keymap.set("n", "<leader>ri",
    "<cmd>:vsplit | te racket -e '(require (file \"" .. vim.fn.expand("%:p") .. "\"))' -i<CR>")

vim.keymap.set("n", "<leader>rs",
    ":vsplit | te racket ~/.config/nvim/racket/stepper.rkt " ..
    vim.fn.expand("%:p") .. " | sed -E \"s/.{2}app //g\" | sed -E \"s/^\\'(.*)\\n//g\"")

vim.keymap.set("n", "<leader>nt", function()
	vim.schedule(function()
		if vim.opt.conceallevel:get() == 2 then
			vim.opt.conceallevel = 0
		elseif vim.opt.conceallevel:get() == 0 then
			vim.opt.conceallevel = 2
		end
	end)
	vim.cmd.Neorg("toggle-concealer")
end)

-- Hex editing
vim.api.nvim_set_keymap("n", "<leader>he", ":%!xxd<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>hr", ":%!xxd -r<CR>", {noremap=true})

-- Music
vim.keymap.set("n", "<leader>mp", ":Music playpause<CR>")
vim.keymap.set("n", "<leader>mn", ":Music next<CR>")
vim.keymap.set("n", "<leader>mb", ":Music prev<CR>")
