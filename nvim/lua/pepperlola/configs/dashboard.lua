-- Cat from https://www.reddit.com/r/neovim/comments/1c0h2sw/comment/kywt3na

-- local logo = [[
    -- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    -- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    -- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    -- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    -- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    -- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

-- ]]
-- ／l、
-- （ﾟ､ ｡ ７
-- l   ~ヽ
-- じしf_,)ノ
local ascii = require('ascii')
local logo = table.concat(ascii.get_random("text", "neovim"), "\n") .. "\n" .. table.concat(ascii.art.animals.cats.kitkat, "\n")

logo = string.rep("\n", 8) .. logo .. "\n\n"

require('dashboard').setup {
    theme = "doom",
    hide = {
        statusline = false,
    },
    config = {
        header = vim.split(logo, "\n"),
        project = {
            enable = true,
        },
        hide = {
            statusline = false,
        },
        center = {
            { action = "FzfLua find_files", desc = "Find File",    icon = " ", key = "f" },
            { action = "ene | startinsert", desc = "New File",     icon = " ", key = "n" },
            { action = "FzfLua oldfiles",   desc = "Recent Files", icon = " ", key = "r" },
            { action = "FzfLua live_grep",  desc = "Find Text",    icon = " ", key = "g" },
            { action = "qa",                desc = "Quit",         icon = " ", key = "q" },
            { action = "Music playpause",   desc = "Play/Pause",   icon = "󰐎 ", key = "p" },
            { action = "Music next",        desc = "Next Track",   icon = "󰒭 ", key = "n" },
            { action = "Music back",        desc = "Prev Track",   icon = "󰒮 ", key = "b" }
        },
        footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
    },
}


