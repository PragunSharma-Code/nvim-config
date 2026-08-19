return {
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
}
