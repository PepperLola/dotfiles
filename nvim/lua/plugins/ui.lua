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
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                background_color = "none"
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        config = function()
            require("noice").setup {
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                }
            }
        end,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            vim.opt.updatetime = 200

            require("barbecue").setup({
                create_autocmd = false,
                theme = 'tokyonight'
            })

            vim.api.nvim_create_autocmd({
                "WinScrolled",
                "BufWinEnter",
                "CursorHold",
                "InsertLeave",
            }, {
                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                callback = function()
                require("barbecue.ui").update()
                end,
            })
        end,
    },
    'ryanoasis/vim-devicons',
    'nvim-tree/nvim-web-devicons',
    'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
	config = function()
		require('barbar').setup {
		    animation = true,
		    clickable = true,
		    theme = 'tokyonight'
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
    -- Status line
    {
        'jcdickinson/wpm.nvim',
        config = function()
            require('wpm').setup()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', "jcdickinson/wpm.nvim" },
        config = function()
            local wpm = require("wpm")
            require('lualine').setup {
                sections = {
                    lualine_x = {
                        wpm.wpm, wpm.historic_graph, "encoding", "fileformat", "filetype"
                    }
                }
            }
        end,
    },
    {
        'airblade/vim-gitgutter',
        branch = 'main'
    },
    "SmiteshP/nvim-navic",
}
