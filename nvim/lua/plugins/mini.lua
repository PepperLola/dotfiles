return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        version = '*',
        config = function()
            local configs = {
                surround = {
                    mappings = {
                        add = "gsa", -- Add surrounding in Normal and Visual modes
                        delete = "gsd", -- Delete surrounding
                        find = "gsf", -- Find surrounding (to the right)
                        find_left = "gsF", -- Find surrounding (to the left)
                        highlight = "gsh", -- Highlight surrounding
                        replace = "gsr", -- Replace surrounding
                        update_n_lines = "gsn",
                    }
                },
                ai = {},
                align = {}
            }

            for name, conf in pairs(configs) do
                require("mini." .. name).setup(conf)
            end
        end
    }
}
