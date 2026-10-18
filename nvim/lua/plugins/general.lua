return {
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },
    {
        'smart-splits-nvim/smart-splits.nvim',
        version = '^3.0.0',
        lazy = false,
        opts = {
            mux = {
                backend = "smart-splits-backend-wezterm",
            },
        },
        dependencies = {
            {
                "smart-splits-nvim/backend-wezterm",
                opts = {
                    cli_path = 'wezterm',
                },
            },
        },
        keys = {
            -- resizing splits, these accept a count, so `10<A-h>` resizes by 10 * config.resize.amount
            {'<A-h>', function() require('smart-splits').resize_left() end},
            {'<A-j>', function() require('smart-splits').resize_down() end},
            {'<A-k>', function() require('smart-splits').resize_up() end},
            {'<A-l>', function() require('smart-splits').resize_right() end},
            -- moving between splits
            {'<C-h>', function() require('smart-splits').move_cursor_left() end},
            {'<C-j>', function() require('smart-splits').move_cursor_down() end},
            {'<C-k>', function() require('smart-splits').move_cursor_up() end},
            {'<C-l>', function() require('smart-splits').move_cursor_right() end},
            -- swapping buffers between windows
            {'<leader><leader>h', function() require('smart-splits').swap_buf_left() end},
            {'<leader><leader>j', function() require('smart-splits').swap_buf_down() end},
            {'<leader><leader>k', function() require('smart-splits').swap_buf_up() end},
            {'<leader><leader>l', function() require('smart-splits').swap_buf_right() end},
            -- Resize windows with C-arrow
            {"<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" }},
            {"<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" }},
            {"<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" }},
            {"<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" }},
        }
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            image = {
                enabled = true
            },
            terminal = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            dashboard = {
                enabled = true,
                sections = {
                    function()
                        local ascii = require("ascii")
                        local logo = table.concat(ascii.get_random("text", "neovim"), "\n") .. "\n" .. table.concat(ascii.art.animals.cats.kitkat, "\n")
                        return { header = logo}
                    end,
                    { section = "keys", padding = 1 },
                    { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            }
        }
    }
}
