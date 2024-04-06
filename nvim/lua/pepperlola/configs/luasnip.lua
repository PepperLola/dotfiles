local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local rec_ls
rec_ls = function()
    return sn(
        nil,
        c(1, {
            t(""),
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        })
    )
end

local typst = {
    s("diagram", {
        t({ "#diagram(", "\tnode-stroke: 1pt,", "\tedge-stroke: 1pt,", "\t" }),
        i(0),
        t({ "", ")" })
    }),
}

local tex = {
    s("ls", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }),
    }),
}

return {
    setup = function()
        ls.filetype_extend("all", { "_" })
        ls.add_snippets("typ", typst)
        ls.add_snippets("tex", tex)
        require('luasnip.loaders.from_vscode').lazy_load()
    end,
}
