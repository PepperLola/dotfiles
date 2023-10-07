-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'junegunn/fzf.vim',
        requires = { 'junegunn/fzf', run = ":call fzf#install()" }
    }

    use 'benknoble/vim-racket'
    use 'Olical/conjure'

    use 'folke/tokyonight.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    vim.cmd('colorscheme tokyonight-night')
    use 'ryanoasis/vim-devicons'
    use 'nvim-tree/nvim-web-devicons'

    use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }
    use {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        },
        after = "nvim-web-devicons"
    }
    use "petertriho/nvim-scrollbar"

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/playground'
    use 'HiPhish/nvim-ts-rainbow2'

    use 'ThePrimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use {
        'airblade/vim-gitgutter',
        branch = 'main'
    }
    use 'wakatime/vim-wakatime'

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use "jcdickinson/wpm.nvim"

    use 'uga-rosa/ccc.nvim'
    use 'tpope/vim-commentary'
    use('prettier/vim-prettier', { run = 'yarn install' })

    use 'prisma/vim-prisma'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {
                'williamboman/mason-lspconfig.nvim',
            },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use 'neovim/nvim-lspconfig'

    --use 'github/copilot.vim'
    use { "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end, }
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })
    use 'eandrju/cellular-automaton.nvim'
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use 'echasnovski/mini.nvim'
    use 'rcarriga/nvim-notify'
    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim',
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'nvim-neotest/neotest-python',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-go',
        }
    }
    use 'folke/neodev.nvim'

    use 'ThePrimeagen/vim-be-good'
    use 'alec-gibson/nvim-tetris'
    use 'seandewar/nvimesweeper'
    use 'jim-fx/sudoku.nvim'
end)
