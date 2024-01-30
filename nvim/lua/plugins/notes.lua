return {
    {
        "epwalsh/obsidian.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "UBC",
                        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UBC"
                    },
                },
            })
        end
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                UBC = "~/Library/Mobile Documents/com~apple~CloudDocs/Notes/UBC",
                            },
                        },
                    },
                },
            }
        end,
    },
}
