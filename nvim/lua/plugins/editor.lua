-- from LazyVim
---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
        return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
    end
    return config
end

return {
    'HiPhish/rainbow-delimiters.nvim',
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        'ThePrimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>ha", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            -- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            -- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            -- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            -- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("neogit").setup {
                integrations = {
                    telescope = true,
                    diffview = true
                },
                graph_style = "kitty"
            }
        end,
        keys = {
            { "<leader>gs", ":Neogit<CR>",                             desc = '[g]it [s]tatus' },
            { "<leader>gc", ":Neogit commit<CR>",                      desc = '[g]it [c]ommit' },
            { "<leader>gp", ":Neogit pull<CR>",                        desc = '[g]it [p]ull' },
            { "<leader>gP", ":Neogit push<CR>",                        desc = '[g]it [P]ush' },
            { "<leader>gb", require('telescope.builtin').git_branches, desc = '[g]it [b]ranches' },
        }
    },
    'subnut/nvim-ghost.nvim',
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = { 'mfussenegger/nvim-dap' },
                keys = {
                    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                    { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
                opts = {},
                config = function(_, opts)
                    local dap = require("dap")
                    local dapui = require("dapui")
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open({})
                    end
                    dap.listeners.after.event_terminated["dapui_config"] = function()
                        dapui.close({})
                    end
                    dap.listeners.after.event_exited["dapui_config"] = function()
                        dapui.close({})
                    end
                end,
            },
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = "mason.nvim",
                cmd = { "DapInstall", "DapUninstall" },
                opts = {
                    automatic_installation = true,
                    handlers = {},
                    ensure_installed = {}
                }
            }
        },
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
            { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
            { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        },
        config = function()
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            local icons = {
                Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
                Breakpoint          = " ",
                BreakpointCondition = " ",
                BreakpointRejected  = { " ", "DiagnosticError" },
                LogPoint            = ".>",
            }

            for name, sign in pairs(icons) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define(
                    "Dap" .. name,
                    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
                )
            end
        end
    },
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
    {
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        opts = {},
        name = 'render-markdown',                                                  -- Only needed if you have another plugin named markdown.nvim
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    }
}
