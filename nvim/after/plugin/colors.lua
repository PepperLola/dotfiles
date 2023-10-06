local transparentBg = true
local util = require("tokyonight.util")

function SetColors(color)
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)

    require("tokyonight").setup {
        transparent = true,
        terminal_colors = true,
    }

    vim.api.nvim_set_hl(0, "LineNr", { fg = util.lighten("#3b4261", 0.9) })

    if transparentBg then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

SetColors()
