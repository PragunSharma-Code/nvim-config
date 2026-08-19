return {
    {
    "echasnovski/mini.map",
    version = false,

    config = function()
        local map = require("mini.map")

        map.setup({
            integrations = {
                map.gen_integration.builtin_search(),
                map.gen_integration.diff(),
                map.gen_integration.diagnostic(),
            },

            symbols = {
                encode = map.gen_encode_symbols.dot("3x2"),
            },

            window = {
                show_integration_count = false,
                width = 10,
                winblend = 15,
            },
        })
        vim.keymap.set("n", "<leader>mm", function()
            map.toggle()
        end, {
            desc = "Toggle minimap",
        })        
    end,
},
    {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                diagnostics = "nvim_lsp",

                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "EXPLORER",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },

                separator_style = "slant",

                show_buffer_close_icons = true,
                show_close_icon = false,
                always_show_bufferline = true,
            },
        })
    end,
},
{
    "nvim-lualine/lualine.nvim",

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("lualine").setup({

    options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "",
        section_separators = "",
    },

    sections = {

        lualine_a = {
            "mode",
        },

        lualine_b = {
            "branch",
            "diff",
            "diagnostics",
        },

        lualine_c = {
            {
                "filename",
                path = 1,
            },
        },

        lualine_x = {
            "filetype",
        },

        lualine_y = {
            "progress",
        },

        lualine_z = {
            "location",
        },
    },
})
    end,
},
     
}
