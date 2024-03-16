return {
    'nvim-lua/plenary.nvim',
    'ThePrimeagen/vim-be-good',
    'alec-gibson/nvim-tetris',
    'seandewar/nvimesweeper',
    'jim-fx/sudoku.nvim',
    'eandrju/cellular-automaton.nvim',
    'wakatime/vim-wakatime',
    {
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("silicon").setup({
                font = "FiraCode NF=34"
            })
        end
    },
    "antoinemadec/FixCursorHold.nvim",
}
