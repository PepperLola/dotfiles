return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true
    },
    { "benlubas/neorg-interim-ls" },
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
                ["external.interim-ls"] = {
                    config = {
                        completion_provider = {
                            enable = true,
                            documentation = true,
                            categories = false
                        }
                    }
                },
                ["core.completion"] = {
                    config = {
                        engine = {
                            module_name = "external.lsp-completion"
                        }
                    }
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            UBC = "~/Library/Mobile Documents/com~apple~CloudDocs/Notes",
                            Synthesis = "~/Desktop/Misc/Synthesis",
                        }
                    }
                },
                ["core.latex.renderer"] = {
                    conceal = false,
                    render_on_enter = true
                }
            }
        }
    },
    {
        "epwalsh/obsidian.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
            workspaces = {
                {
                    name = "UBC",
                    path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/UBC"
                },
            },
        }
    }
}
