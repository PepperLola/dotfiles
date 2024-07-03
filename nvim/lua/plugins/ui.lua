return {
    {
        'folke/tokyonight.nvim',
        config = function()
            local util = require("tokyonight.util")

            require("tokyonight").setup {
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
                terminal_colors = true,
            }

            vim.api.nvim_set_hl(0, "LineNr", { fg = util.lighten("#3b4261", 0.9) })
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        },
        keys = {
            {
                "<leader>hs",
                function()
                    require("gitsigns").stage_hunk()
                end,
                mode = "n",
                desc = "Stage hunk",
            },
            {
                "<leader>hr",
                function()
                    require("gitsigns").reset_hunk()
                end,
                mode = "n",
                desc = "Reset hunk",
            },
            {
                "<leader>hs",
                function()
                    require("gitsigns").stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
                end,
                mode = "v",
                desc = "Stage hunk",
            },
            {
                "<leader>hr",
                function()
                    require("gitsigns").reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
                end,
                mode = "v",
                desc = "Reset hunk",
            },
            {
                "<leader>hS",
                function()
                    require("gitsigns").stage_buffer()
                end,
                desc = "Stage buffer",
            },
            {
                "<leader>hu",
                function()
                    require("gitsigns").undo_stage_hunk()
                end,
                desc = "Undo stage hunk",
            },
            {
                "<leader>hR",
                function()
                    require("gitsigns").reset_buffer()
                end,
                desc = "Reset buffer",
            },
            {
                "<leader>hp",
                function()
                    require("gitsigns").preview_hunk()
                end,
                desc = "Preview hunk",
            },
            {
                "<leader>hb",
                function()
                    require("gitsigns").blame_line { full = true }
                end,
                desc = "Blame line",
            },
            {
                "<leader>tb",
                function()
                    require("gitsigns").toggle_current_line_blame()
                end,
                desc = "Toggle line blame",
            },
            {
                "<leader>hd",
                function()
                    require("gitsigns").diffthis()
                end,
                desc = "Diff",
            },
            {
                "<leader>hD",
                function()
                    require("gitsigns").diffthis('~')
                end,
                desc = "Buffer diff",
            },
            {
                "<leader>td",
                function()
                    require("gitsigns").toggle_deleted()
                end,
                desc = "Toggle deleted",
            },
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        init = function() vim.g.barbar_auto_setup = false end,
        version = '^1.0.0',
        config = function()
            vim.g.barbar_auto_setup = false
            require('barbar').setup {
                animation = true,
                clickable = true,
                theme = 'tokyonight',
                icons = {
                    filetype = {
                        custom_colors = false,
                        enabled = true,
                    },
                },
            }

            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map('n', '<A-,>', '<cmd>BufferPrevious<CR>', opts)
            map('n', '<A-.>', '<cmd>BufferNext<CR>', opts)
            map('n', '≤', '<cmd>BufferPrevious<CR>', opts) -- Alt keys need to be bound to key Mac keyboard produces
            map('n', '≥', '<cmd>BufferNext<CR>', opts)
            map('n', '<A-<>', '<cmd>BufferMovePrevious<CR>', opts)
            map('n', '<A->>', '<cmd>BufferMoveNext<CR>', opts)
            map('n', '¯', '<cmd>BufferMovePrevious<CR>', opts)
            map('n', '˘', '<cmd>BufferMoveNext<CR>', opts)
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
            map('n', '<A-p>', '<cmd>BufferPin<CR>', opts)
            map('n', 'π', '<cmd>BufferPin<CR>', opts)
            map('n', '<A-c>', '<cmd>BufferClose<CR>', opts)
            map('n', 'ç', '<cmd>BufferClose<CR>', opts)
            map('n', '<C-p>', '<cmd>BufferPick<CR>', opts)
            map('n', '<leader>bb', '<cmd>BufferOrderByBufferNumber<CR>', opts)
            map('n', '<leader>bd', '<cmd>BufferOrderByDirectory<CR>', opts)
            map('n', '<leader>bl', '<cmd>BufferOrderByLanguage<CR>', opts)
            map('n', '<leader>bw', '<cmd>BufferOrderByWindowNumber<CR>', opts)
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_y = {
                        "encoding", "fileformat", "filetype"
                    }
                }
            }
        end,
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('pepperlola.configs.dashboard')
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
}
