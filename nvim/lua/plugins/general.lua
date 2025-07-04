return {
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },
    {
        "knubie/vim-kitty-navigator",
        lazy = false,
        build = "cp ./*.py ~/.config/kitty/"
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            image = {
                enabled = true
            },
            terminal = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            dashboard = {
                enabled = true,
                sections = {
                    function()
                        local ascii = require("ascii")
                        local logo = table.concat(ascii.get_random("text", "neovim"), "\n") .. "\n" .. table.concat(ascii.art.animals.cats.kitkat, "\n")
                        return { header = logo}
                    end,
                    { section = "keys", padding = 1 },
                    { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            }
        }
    }
}
