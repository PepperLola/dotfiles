local wpm = require("wpm")

require('lualine').setup({
    sections = {
        lualine_x = {
            wpm.wpm,
            wpm.historic_graph,
            "encoding",
            "fileformat",
            "filetype"
        }
    }
})
