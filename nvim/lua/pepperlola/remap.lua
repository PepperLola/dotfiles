vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Comments
vim.keymap.set("n", "++", "<plug>NERDCommenterToggle")
vim.keymap.set("v", "++", "<plug>NERDCommenterToggle")

-- Move blocks of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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

-- Delete to void register (no copy)
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Save vertical changes on escape
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Queue substitution for current word
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>gp", function()
    vim.ui.input({ prompt = "Are you sure you want to git push? [y/N] " }, function(input)
        if (input == "y") then
            vim.cmd("Git push")
        end
    end)
end)

-- clang-format
vim.keymap.set("n", "<C-K>", ":pyf /opt/homebrew/opt/llvm/share/clang/clang-format.py")

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
