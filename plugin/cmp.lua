print("Configuring cmp...")
local deps_ok, cmp, types, luasnip = pcall(function() 
    return require "cmp",
        require "cmp.types",
        require "luasnip"
end)

if not deps_ok then
    print("missing cmp dependencies")
end

local mapping = cmp.mapping

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"== nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
        ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
        ["<C-k>"] = mapping(function(fallback)
            if cmp.open_docs_preview() then
                cmp.close()
            else
                fallback()
            end
        end),
        ["<C-Space>"] = mapping.complete(),
        ["<C-e>"] = mapping.abort(),
        ["<CR>"] = mapping.confirm { select = false },
        ["<C-n>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-p>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        ["<Tab>"] = mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item { behavior = types.cmp.SelectBehavior.Select }
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Select }
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    })
}) 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline({ '/', '?' }, {
    mapping = mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ':" (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

