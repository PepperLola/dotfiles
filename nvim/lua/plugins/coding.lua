return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "0.1.*",
        build = function() require "typst-preview".update() end,
    },
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
    {
        "mbbill/undotree",
        lazy = false, -- needs to be explicitly set, because of the keys property
        keys = {
            {
                "<leader>u",
                vim.cmd.UndotreeToggle,
                desc = "Toggle undotree",
            },
        },
    },
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
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end,
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-treesitter/nvim-treesitter",
            'nvim-neotest/neotest-python',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-go',
            'rcasia/neotest-java',
            'nvim-neotest/nvim-nio'
        },
        lazy = true,
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
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            }
        }
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {}
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim'},
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<C-f>', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

            require("telescope").setup{}
        end,
    },
    { 'junegunn/fzf',         build = ":call fzf#install()" },
    'junegunn/fzf.vim',
    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            -- Use init for configuration, don't use the more common "config".
        end
    }
}
