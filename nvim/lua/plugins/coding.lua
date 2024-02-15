return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
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
    { 'prettier/vim-prettier', build = 'yarn install' },
    'tpope/vim-commentary',
    {
        'uga-rosa/ccc.nvim',
        config = function()
            local ccc = require("ccc")
            local mapping = ccc.mapping
            ccc.setup {
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                }
            }
        end,
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
        config = function()
            require("refactoring").setup()
        end,
    },
    { 'nvim-neotest/neotest-python', lazy = true },
    { 'nvim-neotest/neotest-plenary', lazy = true },
    { 'nvim-neotest/neotest-go', lazy = true },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            'nvim-neotest/neotest-python',
            'nvim-neotest/neotest-plenary',
            'nvim-neotest/neotest-go',
        },
        config = function()
            require('neotest').setup {
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                    }),
                    require("neotest-plenary"),
                    require("neotest-go"),
                }
            }
        end,
    },
    'folke/neodev.nvim',
    'vim-test/vim-test',
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
}
