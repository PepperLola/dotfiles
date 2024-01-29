local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    { 'junegunn/fzf', build = ":call fzf#install()" },
    'junegunn/fzf.vim',
    {
        "epwalsh/obsidian.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "UBC",
                        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UBC"
                    },
                },
            })
        end
    },

    'folke/tokyonight.nvim',
    { "catppuccin/nvim",                 name = "catppuccin", priority = 1000 },
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
    },
    "SmiteshP/nvim-navic",
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/playground',
    'HiPhish/rainbow-delimiters.nvim',
    "antoinemadec/FixCursorHold.nvim",

    'ThePrimeagen/harpoon',
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'airblade/vim-gitgutter',
        branch = 'main'
    },
    'wakatime/vim-wakatime',

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    "jcdickinson/wpm.nvim",

    'uga-rosa/ccc.nvim',
    'tpope/vim-commentary',
    { 'prettier/vim-prettier', build = 'yarn install' },

    'prisma/vim-prisma',

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true
    },
    'williamboman/mason-lspconfig.nvim',
    'L3MON4D3/LuaSnip',
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
    },
     'hrsh7th/cmp-nvim-lsp' ,
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },

    -- 'github/copilot.vim'
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    'eandrju/cellular-automaton.nvim',
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to  defaults
            })
        end
    },
    'echasnovski/mini.nvim',
    'rcarriga/nvim-notify',
    'vim-test/vim-test',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-go',
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'nvim-neotest/neotest-python',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-go',
        }
    },
    'folke/neodev.nvim',

    'ThePrimeagen/vim-be-good',
    'alec-gibson/nvim-tetris',
    'seandewar/nvimesweeper',
    'jim-fx/sudoku.nvim'
})
