return {
{
    "nvim-tree/nvim-tree.lua",

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("nvim-tree").setup({

            view = {
                width = 32,
                side = "left",
                preserve_window_proportions = true,
            },

            renderer = {
                group_empty = true,

                indent_markers = {
                    enable = true,
                },

                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },

            filters = {
                dotfiles = false,
            },

            git = {
                enable = true,
                ignore = false,
            },

            update_focused_file = {
                enable = true,
                update_root = true,
            },

            respect_buf_cwd = true,

            diagnostics = {
                enable = true,
            },

            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },
        })
    end,
},
    {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    preview_width = 0.55,
                },
                sorting_strategy = "ascending",
                file_ignore_patterns = {
                    ".git/",
                    ".vscode/",
                },
            },
        })
    end,
},
 
} 
