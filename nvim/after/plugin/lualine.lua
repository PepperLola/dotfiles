local wpm = require("wpm")

require('lualine').setup({
    options = {
    },
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
