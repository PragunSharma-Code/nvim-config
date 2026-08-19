return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})
    end,
},

}
