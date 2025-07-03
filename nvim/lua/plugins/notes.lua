return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        lazy = true,
    },
    { "benlubas/neorg-interim-ls" },
    {
        "nvim-neorg/neorg",
        lazy = true,
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
    }
}
