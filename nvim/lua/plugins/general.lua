return {
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.animate').setup()
            require('mini.comment').setup()
            -- require('mini.pairs').setup()
        end,
    },
}
