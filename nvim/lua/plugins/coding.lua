return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "chomosuke/typst-preview.nvim",
        lazy = false,
        version = "0.1.*",
        build = function() require "typst-preview".update() end,
    },
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
    -- 'github/copilot.vim'
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {}
    },
    { 'prettier/vim-prettier', build = 'yarn install' },
    {
        'tpope/vim-commentary',
        config = function()
            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = { "*.m", "*.mm" },
                callback = function()
                    vim.opt_local.commentstring = "// %s"
                end,
            })
        end,
    },
    {
        'uga-rosa/ccc.nvim',
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true,
            }
        }
    },
     {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
    'prisma/vim-prisma',
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {}
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'nvim-neotest/neotest-python',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-go',
            'rcasia/neotest-java',
            'nvim-neotest/nvim-nio'
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                    }),
                    require("neotest-plenary"),
                    require("neotest-go"),
                    require("neotest-java")
                }
            }
        end,
    },
    'folke/neodev.nvim',
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {}
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim', 'ThePrimeagen/refactoring.nvim', 'folke/noice.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<C-h>', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

            require("telescope").setup()
            require("telescope").load_extension("refactoring")
            require("telescope").load_extension("noice")
        end,
    },
    { 'junegunn/fzf', build = ":call fzf#install()" },
     'junegunn/fzf.vim',
    {
      "lervag/vimtex",
      init = function()
        -- Use init for configuration, don't use the more common "config".
      end
    }
}
