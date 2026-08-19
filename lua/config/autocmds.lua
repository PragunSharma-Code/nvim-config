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
    
