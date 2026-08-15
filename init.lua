vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "lua", "python", "javascript", "typescript", "java" },
    callback = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldenable = true
        vim.wo.foldlevel = 99
    end,
})
vim.api.nvim_set_hl(0, "LineNr", {
    fg = "#7C83A0",
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = "#FFFFFF",
    bold = true,
})

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.foldcolumn = "1"

vim.opt.fillchars = {
    foldopen = "▾",
    foldclose = "▸",
    fold = " ",
    foldsep = " ",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
    "lewis6991/gitsigns.nvim",

    config = function()
        require("gitsigns").setup()
    end,
},
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
    "neovim/nvim-lspconfig",
},
    {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]],
            direction = "horizontal",
            shade_terminals = true,
            float_opts = {
                border = "rounded",
            },
        })
    end,
},
    {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})
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
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
        require("catppuccin").setup({
            flavour = "mocha",

            integrations = {
                nvimtree = true,
                treesitter = true,
                cmp = true,
                telescope = true,
            },
        })

        vim.cmd.colorscheme("catppuccin")
    end,
},
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

-- Lualine
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

{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        dashboard = {
            enabled = true,

            preset = {
                header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝
                ]],
            },
        },
    },
},
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    {
    "neovim/nvim-lspconfig",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config("clangd", {
            cmd = { "clangd" },
            capabilities = capabilities,
        })

        vim.lsp.enable("clangd")
    end,
},    
{
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "onsails/lspkind.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        cmp.setup({

            -- Snippets
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- Keymaps
            mapping = cmp.mapping.preset.insert({

                -- Open completion manually
                ["<C-Space>"] = cmp.mapping.complete(),

                -- Confirm selected suggestion
                ["<CR>"] = cmp.mapping.confirm({
                    select = false,
                }),

                -- Smart Tab
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()

                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()

                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Smart Shift + Tab
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()

                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)

                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Close completion
                ["<C-e>"] = cmp.mapping.abort(),
            }),

            -- Completion sources
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),

            -- Icons + labels
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,

                    menu = {
                        nvim_lsp = "[LSP]",
                        luasnip = "[SNIP]",
                        buffer = "[BUF]",
                        path = "[PATH]",
                    },
                }),
            },

            -- Nice borders
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- Subtle inline suggestion
            experimental = {
                ghost_text = true,
            },
        })
    end,
},
   {
    "stevearc/conform.nvim",

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                cpp = { "clang_format" },
                c = { "clang_format" },
            },

            format_on_save = false,
        })
vim.keymap.set({ "n", "i", "v" }, "<S-A-f>", function()
    require("conform").format({
        lsp_fallback = true,
    })
end, { desc = "Format file" })
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
})
require("luasnip.loaders.from_lua").load({
  paths = {
        vim.fn.stdpath("config") .. "/snippets",
    },
})

if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    vim.cmd("NvimTreeOpen")
end
-- Ctrl + A → Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })


-- Arrow keys in normal mode
vim.keymap.set("n", "<Up>", "k")
vim.keymap.set("n", "<Down>", "j")
vim.keymap.set("n", "<Left>", "h")
vim.keymap.set("n", "<Right>", "l")


-- Shift + Arrow → selection in normal mode
vim.keymap.set("n", "<S-Up>", "Vk")
vim.keymap.set("n", "<S-Down>", "Vj")
vim.keymap.set("n", "<S-Left>", "vh")
vim.keymap.set("n", "<S-Right>", "vl")
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-Tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<C-w>", "<cmd>bdelete<CR>")
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("i", "<C-v>", '<C-r>+')
vim.keymap.set("v", "<C-x>", '"+d')
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("i", "<C-z>", "<C-o>u")
-- New file
vim.keymap.set("n", "<C-n>", function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()

    local path = node.absolute_path

    if node.type ~= "directory" then
        path = vim.fn.fnamemodify(path, ":h")
    end

    vim.ui.input({ prompt = "New file: " }, function(name)
        if name and name ~= "" then
            local file = path .. "/" .. name
            vim.fn.writefile({}, file)
            vim.cmd("edit " .. vim.fn.fnameescape(file))
        end
    end)
end, { desc = "New file" })


-- New folder
vim.keymap.set("n", "<C-S-n>", function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()

    local path = node.absolute_path

    if node.type ~= "directory" then
        path = vim.fn.fnamemodify(path, ":h")
    end

    vim.ui.input({ prompt = "New folder: " }, function(name)
        if name and name ~= "" then
            vim.fn.mkdir(path .. "/" .. name, "p")
            api.tree.reload()
        end
    end)
end, { desc = "New folder" })

vim.keymap.set("n", "<C-A-Space>", function()
    vim.cmd("write")

    local file = vim.fn.expand("%:p")
    local executable = "/tmp/nvim_dsa_program"

    vim.cmd("botright 12split")
    vim.cmd("terminal g++ -std=c++17 -O2 " ..
        vim.fn.shellescape(file) ..
        " -o " ..
        vim.fn.shellescape(executable) ..
        " && " ..
        vim.fn.shellescape(executable))

    vim.cmd("startinsert")
end, { desc = "Compile and Run C++" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Show diagnostic",
})
-- Ctrl + Backspace → delete previous word
vim.keymap.set("i", "<C-BS>", "<C-W>", {
    desc = "Delete previous word",
})

-- Fallback for terminals that send Ctrl+Backspace as Ctrl-H
vim.keymap.set("i", "<C-H>", "<C-W>", {
    desc = "Delete previous word",
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})
