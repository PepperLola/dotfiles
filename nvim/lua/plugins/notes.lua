return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true
    },
    {
        "nvim-neorg/neorg",
        dependencies = {"luarocks.nvim"},
        lazy = false,
        version = "*",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.highlights"] = {},
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    }
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            UBC = "~/Library/Mobile Documents/com~apple~CloudDocs/Notes",
                            Synthesis = "~/Desktop/Misc/Synthesis",
                        }
                    }
                }
            }
        }
    },
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
    }
}
