return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("clangd", {
                cmd = { "clangd" },
                capabilities = capabilities,
            })
vim.lsp.config("vtsls", {
    capabilities = capabilities,

    settings = {
        javascript = {
            suggest = {
                autoImports = true,
                completeFunctionCalls = true,
            },

            updateImportsOnFileMove = {
                enabled = "always",
            },

            preferences = {
                importModuleSpecifier = "shortest",
            },
        },

        typescript = {
            suggest = {
                autoImports = true,
                completeFunctionCalls = true,
            },

            updateImportsOnFileMove = {
                enabled = "always",
            },

            preferences = {
                importModuleSpecifier = "shortest",
            },
        },

        vtsls = {
            autoUseWorkspaceTsdk = true,
        },
    },
})
            vim.lsp.config("eslint", {
              capabilities = capabilities,
            })

            vim.lsp.enable("clangd")
            vim.lsp.enable("vtsls")
            vim.lsp.enable("eslint")
        end,
    },
} 
