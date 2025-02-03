return {
    {
        "echasnovski/mini.nvim",
        version = '*',
        config = function()
            local configs = {
                surround = {},
                ai = {},
                align = {}
            }

            for name, conf in pairs(configs) do
                require("mini." .. name).setup(conf)
            end
        end
    }
}
