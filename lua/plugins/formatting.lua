return {
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

}
