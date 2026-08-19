vim.g.mapleader = " "
require("config.options")
require("config.keymaps")
require("config.autocmds")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
    {import = "plugins"},

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

})

require("luasnip.loaders.from_lua").load({
  paths = {
        vim.fn.stdpath("config") .. "/snippets",
    },
})

if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    vim.cmd("NvimTreeOpen")
end
