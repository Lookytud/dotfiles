return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = true,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
        },
        config = function()
            local noice = require("noice")

            noice.setup({
                cmdline = {
                    enabled = true,
                    view = "cmdline_popup",
                    format = {
                        cmdline = { pattern = "", icon = "󱐌 :", lang = "vim" },
                        help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰮦 :" },
                        search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
                        filter = { pattern = "^:%s*!", icon = " $ :", lang = "bash" },
                        lua = {
                            pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                            icon = "  :",
                            lang = "lua",
                        },
                        input = { view = "cmdline_input", icon = " 󰥻 :" }, -- Used by input()
                    },
                },
                views = {
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                    },
                    hover = {
                        backend = "popup",
                        relative = "cursor",
                        position = {
                            row = 1, -- row=1 means it pops *below* the cursor line
                            col = 1, -- a small col offset so it’s not right over the text
                        },
                        border = {
                            style = "rounded",
                        },
                        zindex = 100,
                        win_options = {
                            winblend = 0,
                            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                            cursorline = false,
                            number = false,
                            relativenumber = false,
                        },
                    },
                    mini = {
                        size = {
                            width = "auto",
                            height = "auto",
                            max_height = 15,
                        },
                        position = {
                            row = -2,
                            col = "100%",
                        },
                    }
                },
                lsp = {
                    progress = {
                        enabled = true,
                    },
                    hover = {
                        enabled = false,
                        view = "hover", -- ensures it uses the "hover" popup defined in views
                    },
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                    signature = {
                        auto_open = { enabled = false }, -- disable auto signature help on insert mode
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        view = "mini",
                    },
                    {
                        filter = {
                            event = "notify",
                            find = "Invalid mapping for .*", -- Just the part that's common in the message
                        },
                        opts = { skip = true },
                    },
                },
                messages = {
                    enabled = true,
                },
                health = {
                    checker = true,
                },
                popupmenu = {
                    enabled = true,
                },
                signature = {
                    enabled = true,
                },
            })
        end
    }
}
