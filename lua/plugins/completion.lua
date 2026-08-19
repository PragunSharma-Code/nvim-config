return {
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
             preselect = cmp.PreselectMode.Item,

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
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 750 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
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

}
