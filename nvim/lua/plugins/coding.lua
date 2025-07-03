return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = true,
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
        'tpope/vim-sleuth'
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
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { },
        keys = {
            { "<C-f>", "<cmd>FzfLua files<CR>", desc = "Find files" },
            { "<C-p>", "<cmd>FzfLua git_files<CR>", desc = "Git files" },
            { "<C-g>", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" }
        }
    },
    { 'junegunn/fzf', build = ":call fzf#install()" },
    'junegunn/fzf.vim',
    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            -- Use init for configuration, don't use the more common "config".
        end
    }
}
